
# Objetos HTML básicos para uso em React

Elementos HTML fundamentais utilizados na construção de interfaces em React, com foco em uso prático, semântica e boas práticas.

---

## O que são

São elementos HTML nativos (`div`, `span`, `button`, etc.) usados dentro de JSX para estruturar, apresentar e permitir interação em aplicações React.

Em React, eles:

* São escritos como JSX
* Aceitam props em formato camelCase
* Podem ser combinados com lógica JavaScript

---

## Modelo mental

```
HTML nativo
   ↓
JSX (React)
   ↓
DOM real
```

React não cria novos elementos HTML — ele apenas **declara como o DOM deve ser**.

---

## Quando usar

* Construção de layouts
* Estruturação semântica
* Inputs e interações do usuário
* Renderização de texto e mídia

---

## Quando NÃO usar

* Quando existe um componente reutilizável mais semântico
* Quando o elemento quebra acessibilidade
* Quando um componente abstraído já resolve o problema

---

## Elementos estruturais

### `div`

Contêiner genérico sem semântica.

```tsx
<div className="container"></div>
```

Use para layout e agrupamento.

---

### `span`

Contêiner inline, sem quebra de linha.

```tsx
<span>Texto</span>
```

Use para pequenos trechos de texto.

---

### `main`, `section`, `article`, `aside`

Elementos semânticos de layout.

```tsx
<main>
  <section>
    <article></article>
  </section>
</main>
```

Melhoram acessibilidade e SEO.

---

## Elementos de texto

### `p`

Parágrafo de texto.

```tsx
<p>Texto</p>
```

---

### `h1` – `h6`

Títulos hierárquicos.

```tsx
<h1>Título principal</h1>
```

Nunca pule níveis sem motivo.

---

## Elementos interativos

### `button`

Ação clicável.

```tsx
<button onClick={handleClick}>Enviar</button>
```

Preferível a `div` clicável.

---

### `a`

Link de navegação.

```tsx
<a href="/rota">Link</a>
```

Use `Link` (Next.js / React Router) quando aplicável.

---

## Elementos de formulário

### `input`

Entrada de dados.

```tsx
<input type="text" value={value} onChange={handleChange} />
```

Sempre controlado quando possível.

---

### `textarea`

Texto multilinha.

```tsx
<textarea value={text} onChange={handleChange} />
```

---

### `label`

Rótulo de input.

```tsx
<label htmlFor="email">Email</label>
```

Use `htmlFor` em vez de `for`.

---

## Elementos de mídia

### `img`

Imagem.

```tsx
<img src="/image.png" alt="Descrição" />
```

`alt` é obrigatório para acessibilidade.

---

### `video`

Mídia de vídeo.

```tsx
<video controls src="/video.mp4" />
```

---

## Propriedades importantes em React

### `className`

Substitui `class`.

```tsx
<div className="box" />
```

---

### `htmlFor`

Substitui `for`.

```tsx
<label htmlFor="id" />
```

---

### `onClick`, `onChange`, etc.

Eventos em camelCase.

```tsx
<button onClick={fn} />
```

---

## Erros comuns

❌ Usar `class` em vez de `className`
❌ Usar `for` em vez de `htmlFor`
❌ Usar `div` para tudo
❌ Ignorar semântica
❌ Ignorar acessibilidade

---

## Boas práticas

✅ Use elementos semânticos
✅ Prefira `button` a `div` clicável
✅ Use `alt`, `label`, `aria-*` quando necessário
✅ Componentize padrões repetidos

---

## Resumo rápido

* JSX usa HTML nativo
* Props usam camelCase
* Semântica importa
* Acessibilidade é responsabilidade do dev
* React não muda o HTML, só declara o DOM

# Gemini Reply:

## 1. GLOSSÁRIO: OBJETOS HTML PARA REACT (JSX)

### 2.1 Elementos de Estrutura e Container

* **div**: Elemento de bloco genérico para agrupamento.
* **span**: Elemento de linha para estilização de fragmentos.
* **Fragment (<> ou <React.Fragment>)**: Agrupador lógico que evita a criação de nós extras no DOM.

### 2.2 Formulários e Entrada de Dados

* **form**: Container de formulário associado ao evento `onSubmit`.
* **input**: Campo de entrada auto-fechado. Atributos: `type`, `value`, `onChange`.
* **label**: Rótulo de campo. Utiliza `htmlFor` em vez de `for`.
* **textarea**: Campo de texto multilinha com estado gerenciado por `value`.
* **select / option**: Listas de seleção controladas pelo `value` do pai.
* **button**: Gatilho de interação via evento `onClick`.

### 2.3 Texto e Mídia

* **h1 - h6**: Hierarquia de cabeçalhos.
* **p**: Definição de parágrafos.
* **a**: Hiperlinks (em SPAs, frequentemente substituído por componentes de Router).
* **img**: Elemento auto-fechado. Requer atributos `src` e `alt`.

### 2.4 Listas e Tabelas

* **ul / ol / li**: Estruturas de listas. Itens iterados exigem a prop `key`.
* **table / tr / td / th**: Estrutura para representação de dados tabulares.

### 2.5 Especificações Técnicas JSX

* **Atributos**: Devem seguir o padrão camelCase (ex: `className`, `tabIndex`).
* **Inline Styles**: Recebem objetos literais (ex: `style={{ color: 'red' }}`).
* **Fechamento**: Tags sem conteúdo devem ser obrigatoriamente auto-fechadas (ex: `<br />`).
* **dangerouslySetInnerHTML**: Atributo para inserção de HTML bruto sob risco de segurança.

