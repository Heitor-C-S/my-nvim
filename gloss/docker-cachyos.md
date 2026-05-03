# GLOSSARY: ADVANCED CONTAINERIZATION ARCHITECTURE

# CONTEXT: CACHYOS, NEXT.JS, NEOVIM

## 1. KERNEL PRIMITIVES & OS ARCHITECTURE

### Namespaces

Kernel feature that partitions system resources such that a set of processes sees one set of resources while another set sees a different set. The foundation of container isolation.

- **PID Namespace**: Isolates the process ID number space. Process ID 1 inside the container is distinct from the host PID.
- **Network Namespace**: Isolates network stack (interfaces, routing tables, firewall rules).
- **Mount Namespace**: Isolates mount points, allowing containers to have distinct file system roots.
- **User Namespace**: Maps user IDs (UIDs) and group IDs (GIDs) between the container and the host. Allows a process to be `root` inside a container but unprivileged on the host.

### Control Groups (Cgroups v2)

Kernel mechanism for organizing processes hierarchically and distributing system resources (CPU, memory, I/O) along the hierarchy.

- **Unified Hierarchy**: Unlike v1, v2 uses a single hierarchy for all controllers.
- **OOM Killer (Out of Memory)**: Kernel process that terminates processes when memory is exhausted. Docker uses Cgroups to set memory limits (`memory.max`) to trigger container-specific OOM kills rather than system-wide instability.

### sched-ext (SCX)

Extensible Scheduler Class. A feature in CachyOS/Arch kernels enabling CPU schedulers to be implemented in BPF (Berkeley Packet Filter) and loaded dynamically from userspace.

- **scx_rusty**: Throughput-oriented scheduler. Ideal for batch tasks like `npm run build` or compilation.
- **scx_lavd**: Latency-criticality Aware Virtual Deadline scheduler. Ideal for interactive tasks, gaming, and responsive development servers (HMR).
- **scx_bpfland**: A vruntime-based scheduler prioritizing interactivity and fairness.

### Zombie Processes

Child processes that have terminated but whose exit status has not been collected ("reaped") by their parent.

- **PID 1 Responsibility**: The init process must reap zombies. Node.js is not designed as an init process.
- **Tini**: A minimal init system injected by Docker (`--init` flag) to handle signal forwarding and zombie reaping.

## 2. DOCKER INTERNALS & FILESYSTEM

### Union Filesystem (OverlayFS)

Layered file system service used by Docker. Allows multiple read-only layers (images) to be overlaid with a read-write layer (container execution).

- **Copy-on-Write (CoW)**: Strategy where data is shared between layers until modified, at which point it is copied to the writable layer.

### User Remapping (UID/GID)

The alignment of the container's internal user ID with the host's user ID to prevent permission errors on bind-mounted volumes.

- **Configuration**: `user: "${UID}:${GID}"` in `compose.yaml`.
- **Necessity**: Without this, files created by the container (e.g., build artifacts) are owned by `root`, making them uneditable by the host user without `sudo`.

### Networking Stack

- **veth (Virtual Ethernet)**: A pair of virtual network interfaces acting as a pipe. One end resides in the container (eth0), the other on the host attached to the bridge.
- **Bridge (docker0)**: Virtual Layer 2 switch connecting container veth interfaces.
- **Masquerading (NAT)**: Method used by Docker to route container traffic to the external network using the host's IP address.

## 3. NEXT.JS & BUILD OPTIMIZATION

### Standalone Output

Next.js build configuration (`output: 'standalone'`) that leverages output file tracing to create a minimal production deployment.

- **Mechanism**: Analyzes `import` statements to copy only necessary files to `.next/standalone`.
- **Benefit**: Reduces Docker image size by excluding unused `node_modules` and `devDependencies`.

### Multi-Stage Builds

Dockerfile pattern employing multiple `FROM` instructions.

- **Deps Stage**: Installs dependencies (cacheable).
- **Builder Stage**: Compiles code (resource intensive).
- **Runner Stage**: Minimal runtime environment containing only artifacts.
- **Security**: Ensures build tools, secrets, and cache do not persist in the final image.

### File Watching (HMR)

- **Inotify**: Linux kernel subsystem that notices changes to the filesystem and reports them to applications.
- **Polling**: Fallback mechanism (`WATCHPACK_POLLING=true`) where the application periodically scans files for changes. Required when Inotify events fail to propagate across file system boundaries (e.g., certain Docker storage drivers or network mounts).

## 4. DEVELOPMENT ENVIRONMENT (NEOVIM/LSP)

### LSP (Language Server Protocol)

Protocol used by Neovim to provide Intellisense (auto-complete, go-to-definition).

- **Boundary Issue**: Host-based LSP cannot read dependencies inside the container.
- **Hybrid Solution**: Maintain a local `node_modules` on the host for LSP indexing, while using containerized `node_modules` for execution.

### DAP (Debug Adapter Protocol)

Protocol for generic debuggers.

- **V8 Inspector**: Node.js debugging interface exposed via `--inspect`.
- **Port Mapping**: Requires mapping `0.0.0.0:9229` in the container to access from the host.
- **Path Mapping**: DAP configuration (`localRoot` vs `remoteRoot`) is required to map host source files to container runtime scripts.

## 5. COMMAND REFERENCE

### Docker Lifecycle

- `docker compose up -d --build`: Force rebuild of images and start detached.
- `docker system prune -a`: Remove all unused images, containers, and networks.
- `ctop`: Terminal-based container monitoring interface.

### Kernel Tuning (Host)

- `sysctl -w fs.inotify.max_user_watches=524288`: Increase file watch limit for large projects.
- `scx_loader_ui`: GUI/TUI to switch sched-ext schedulers on CachyOS.
