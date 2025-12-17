# Guia Completo: `motion.div` no Framer Motion (React)

Este documento explica em profundidade como funciona o `motion.div`,
como o Framer Motion lida com animações, e como aplicar esses conceitos
em qualquer componente React (menus, modais, listas, cards, etc).

---

## 1. O que é o `motion.div`

`motion.div` é uma versão animável do elemento HTML `<div>`.

```jsx
import { motion } from "framer-motion";

<motion.div />;
```

Tudo que um `div` faz, o `motion.div` também faz — com a diferença que ele aceita **propriedades de animação**

você pode pensar assim:

### | `motion div = div + animação declarativa`

## 2. Conceito central do Framer Motion

Framer motion trabalha com **estados visuais**, não com frames.

Você decreve:

- Onde o elemento começa
- Onde ele termina
- Como ele sai

E o framer motion calcula o resto.

---

## 3. As 3 propriedades fundamentais:

```jsx
<motion.div
  initial={{ opacity: 0 }}
  animate={{ opacity: 1 }}
  exit={{ opacity: 0 }}
/>
```

O que cada uma faz:

| Propriedade | Quando acontece      | Função            |
| ----------- | -------------------- | ----------------- |
| `initial`   | Quando entra no DOM  | Estado inicial    |
| `animate`   | Logo após montar     | Estado final      |
| `exit`      | Antes de sair do DOM | Animação de saída |

Modelo mental

```
initial -> animate -> exit
```

## 4. `initial`

define como o elemento nasce.

```jsx
initial={{ opacity: 0, y: -20 }}
```

Exemplos comuns:

- Invisível (opacity: 0)

- Fora da tela (x, y)

- Menor (scale: 0.9)

## 5. `animate`

Define o estado final da animação.

```
animate={{ opacity: 1, y: 0 }}
```

Esse estado é:

- Persistente
- Atualizável (pode mudar conforme props ou state)

## 6. `exit`

define como o elemento morre.

```jsx
exit={{ opacity: 0, y: -20 }}
```

⚠️ Importante:
Para `exit` funcionar, o componente precisa estar dentro de
`<AnimatePresence>`.

## 7. AnimatePresence (Obrigatório para exit)

```jsx
<AnimatePresence>
  {isOpen && <motion.div exit={{ opacity: 0 }} />}
</AnimatePresence>
```

**Porque isso existe?**

Sem `AnimatePresence`:

- React remove o elemento imediatamente

Com `AnimatePresence`:

- Framer Motion anima
- Depois o elemento é desmontado

**Modelo mental**

AnimatePresence = "Espere a animação terminar antes de remover"

## 8. Propriedades animáveis mais usadas

**Opacidade**

Opacidade

```jsx
opacity: 0 → 1
```

Movimento

```jsx
x: -50 → 0
y: 20 → 0
```

Escala

```jsx
scale: 0.95 → 1
```

Rotação

```jsx
rotate: 0 → 90
```

## 9. transition

Controla como a animação acontece.

```
transition={{ duration: 0.2 }}
```

Opções comuns

```jsx
transition={{
  duration: 0.3,
  ease: "easeOut"
}}
```

```jsx
transition={{
  type: "spring",
  stiffness: 300,
  damping: 25
}}
```

**Modelo mental**

- duration → tempo
- ease → suavidade
- spring → animação física

## 10. Por que Framer Motion é performático

Framer Motion usa:

- transform
- opacity

Isso significa:

- GPU acceleration
- Menos reflow
- Animações suaves

## 11. Atualizando animações com state

```jsx
<motion.div animate={{ x: isOpen ? 0 : -100 }} />
```

Sempre que isOpen mudar:

- O Framer Motion anima automaticamente

Sem `useEffect` .

Sem lógica manual.

12. Variants (animações reutilizáveis)

```jsx
const variants = {
  hidden: { opacity: 0 },
  visible: { opacity: 1 },
};

<motion.div variants={variants} initial="hidden" animate="visible" />;
```

Use `variants` quando:

- Muitos elementos compartilham animação
- Você quer padronização

## 13. Casos de uso comuns

**Modal**

- `scale + opacity`

- `exit` animado

**Dropdown**

- `y + opacity`

- Entrada rápida

**Sidebar**

- x negativo → 0

**Lista**

- Animação item por item

- Entrada escalonada

## 14. Erros comuns

❌ Usar exit sem AnimatePresence

❌ Animar width e height diretamente

❌ Animações longas demais

❌ Misturar CSS animation com Framer Motion

## 15. Resumo mental final

**Pense sempre assim:**

- State controla existência

- motion.div controla visual

- Framer Motion controla transição

Fluxo

```
state → mount → animate → unmount
```
