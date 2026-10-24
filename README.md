# Neovim como consola de revisión

Configuración personal para explorar proyectos, revisar los cambios escritos por un agente y consultar tests sin salir de la terminal. También permite editar, navegar por símbolos y formatear C/C++ y Python.

## Instalación en otra máquina

Necesitas Git y Neovim moderno. La configuración usa APIs LSP de Neovim 0.11+, pero los plugins pueden exigir versiones posteriores: se ha comprobado localmente con Neovim 0.12.6.

Si ya existe `~/.config/nvim`, respáldala antes de clonar. No clones encima de tu configuración anterior.

```bash
git clone git@github.com:DenilDenilson/nvim.git ~/.config/nvim
nvim
```

La URL SSH requiere acceso a GitHub con una clave SSH. Si el repositorio es público, también puedes clonar por HTTPS:

```bash
git clone https://github.com/DenilDenilson/nvim.git ~/.config/nvim
```

`lazy.nvim` se instala automáticamente al iniciar. Después ejecuta dentro de Neovim:

```vim
:Lazy restore
```

Esto recupera las versiones de plugins fijadas en `lazy-lock.json`. Espera a que terminen las instalaciones y vuelve a abrir Neovim.

### Herramientas externas

Clonar el repositorio no instala estas dependencias del sistema:

| Herramienta | Para qué se usa |
|---|---|
| `ripgrep` (`rg`) | Buscar texto del proyecto con Telescope |
| Compilador C y herramientas requeridas por Tree-sitter | Instalar parsers de sintaxis; consulta `:checkhealth nvim-treesitter` |
| `clangd` | LSP de C/C++ |
| `basedpyright-langserver` | LSP y análisis de tipos de Python |
| `ruff` | Diagnósticos y formato de Python |
| `clang-format` | Formato de C/C++ |
| Python y `pytest` | Ejecutar tests Python |
| `lazygit` (opcional) | Interfaz de Git en una pestaña de terminal |
| Proveedor de portapapeles | Copiar/pegar con el sistema; por ejemplo, `wl-clipboard` en Wayland |
| Nerd Font (opcional) | Ver correctamente los iconos del árbol |

**Mason sí está configurado**, pero no tiene una lista de instalación automática. Abre `:Mason`, busca las herramientas y pulsa `i` para instalarlas. Puedes instalar las herramientas LSP y formateadores desde allí o proporcionarlas mediante el sistema.

Neotest prioriza `.venv/bin/python` en el directorio desde el que trabajas; si no existe, usa `python` del sistema. Instala las dependencias de tests del proyecto en ese entorno.

Lazydocker no está integrado: úsalo en otra ventana de terminal para contenedores y logs.

## Primeros pasos

Abre Neovim desde la raíz del proyecto, no desde la carpeta de esta configuración:

```bash
cd /ruta/al/proyecto
nvim
```

- `Esc` vuelve al modo normal desde inserción o selección.
- `i` entra en modo inserción; `v` inicia selección visual.
- `:` abre la línea de comandos; confirma los comandos con `Enter`.
- `Esp` en las tablas significa **Espacio**, tu tecla `leader`. Por ejemplo, `Esp gd` es Espacio, luego `g`, luego `d`; no se presionan juntas.
- `Ctrl+h` y `Alt+h` sí son combinaciones simultáneas.
- Mayúsculas y minúsculas importan: `Esp fR` no es `Esp fr`.
- Los atajos son de **modo normal**, excepto los de terminal indicados más abajo.
- Pulsa Espacio y espera para ver sugerencias de which-key. `Esp ?` muestra los mapas locales del buffer, no todos los mapas globales.

### Rutina de revisión del agente

1. `Esp e`: explora el proyecto. `Enter` abre archivos o expande directorios.
2. Pide un cambio al agente desde otra ventana de terminal.
3. `Esp gd`: abre Diffview para revisar los cambios sin commit.
4. Selecciona archivos en el panel del diff y recorre los bloques con `]c` y `[c`.
5. Si el agente sigue editando, `Esp gr` refresca el diff.
6. `Esp gq`: cierra la revisión y vuelve al código.
7. `Esp tf`: ejecuta los tests del archivo; `Esp ts` abre el árbol de tests y `Esp to` su salida.
8. `Esp gg`: abre Lazygit cuando quieras revisar el estado completo, preparar un commit o consultar ramas.

No necesitas abrir todos los paneles a la vez. Alterna entre **exploración** (árbol + código), **revisión** (Diffview) y **tests**.

## Atajos

### Guardar, salir y buffers

Un buffer es un archivo cargado; una ventana muestra un buffer; una pestaña contiene una distribución de ventanas.

| Teclas | Acción |
|---|---|
| `Esp w` | Guardar el archivo |
| `Esp q` | Cerrar la ventana actual; salir si es la última |
| `Esp wq` | Guardar y cerrar la ventana actual |
| `Esp bb` | Listar buffers y preparar `:b`; escribe un número/nombre y pulsa Enter |
| `Esp bn` / `Esp bp` | Buffer siguiente / anterior |
| `Esp bd` | Cerrar buffer |
| `Esp Esp` | Alternar con el último buffer |

`Esp w` comparte prefijo con `Esp wq`: al guardar puede haber una pequeña espera. `Esp x` ya no guarda y sale, para no interferir con Trouble.

### Ventanas y pestañas

| Teclas | Acción |
|---|---|
| `Esp sv` / `Esp sh` | Dividir vertical / horizontalmente |
| `Esp se` | Igualar el tamaño de las ventanas |
| `Esp sx` | Cerrar ventana |
| `Ctrl+h/j/k/l` | Moverse izquierda / abajo / arriba / derecha |
| `Alt+h/j/k/l` | Redimensionar hacia izquierda / abajo / arriba / derecha |
| `Alt+,` / `Alt+.` | Pestaña anterior / siguiente |
| `Alt+1` a `Alt+4` | Ir a la pestaña correspondiente |

Para crear una pestaña puedes usar `:tabnew`. Si tu terminal o gestor de ventanas captura Alt, esos atajos no llegarán a Neovim.

### Árbol del proyecto — Neo-tree

| Teclas | Acción |
|---|---|
| `Esp e` | Mostrar/ocultar árbol de archivos y revelar el archivo actual |
| `Esp ge` | Mostrar/ocultar árbol de cambios Git |
| `Enter` dentro del árbol | Abrir archivo o expandir/contraer directorio |
| `?` dentro del árbol | Mostrar ayuda de sus atajos |

El árbol sigue el archivo actual, muestra archivos ocultos y observa cambios del sistema de archivos. Puede seguir ocultando archivos ignorados por Git; consulta `?` para los controles de filtrado. No es el mismo panel que el listado de archivos de Diffview.

### Git — Diffview, Gitsigns y Lazygit

| Teclas | Acción |
|---|---|
| `Esp gd` | Abrir revisión de cambios con Diffview |
| `Esp gh` | Historial Git del archivo actual |
| `Esp gr` | Refrescar Diffview |
| `Esp gq` | Cerrar Diffview |
| `]c` / `[c` | Bloque cambiado siguiente / anterior |
| `Esp gp` | Previsualizar bloque cambiado con Gitsigns |
| `Esp gb` | Consultar autor de la línea con Gitsigns |
| `Esp gg` | Abrir Lazygit en una pestaña nueva |

Gitsigns añade marcas al margen de los archivos que puede asociar al repositorio. Sus atajos de bloque y autor se registran al adjuntarse a ese buffer; dentro de ventanas diff, `]c` y `[c` conservan la navegación nativa del diff.

Para trabajar con la lista de archivos de Diffview usa `:DiffviewFocusFiles` y selecciona un archivo con Enter. `:DiffviewToggleFiles` muestra/oculta ese panel.

Otros comandos útiles (sustituye `main` por la rama base de tu proyecto):

```vim
:DiffviewOpen --cached
:DiffviewOpen main...HEAD
:DiffviewFileHistory
:DiffviewFileHistory %
```

El primero muestra cambios preparados para commit; el segundo compara los commits de tu rama desde su base común con `main`, no los cambios sin commit. Los dos últimos muestran historial del proyecto o del archivo actual.

Al salir de Lazygit con su tecla de salida, queda la pestaña de terminal. Usa `Ctrl+g` si sigues en modo terminal y después `:q` para cerrarla. Revisar un diff no crea commits ni descarta cambios automáticamente; las operaciones de Git que elijas en Lazygit sí modifican el repositorio.

### Buscar — Telescope

| Teclas | Buscar |
|---|---|
| `Esp ff` | Archivos |
| `Esp fg` | Texto dentro del proyecto; requiere `rg` |
| `Esp fb` | Buffers abiertos |
| `Esp fr` | Archivos recientes |
| `Esp fh` | Ayuda de Neovim y plugins |
| `Esp fi` | Implementaciones LSP |
| `Esp fd` | Definiciones LSP |
| `Esp fR` | Referencias LSP |
| `Esp fs` | Símbolos del archivo |
| `Esp fS` | Símbolos del proyecto |

En los buscadores escribe para filtrar y pulsa Enter para abrir el resultado. Puedes cambiar de resultado con `Ctrl+n` / `Ctrl+p` y cerrar con Esc en modo normal.

### Marcar archivos — Harpoon

| Teclas | Acción |
|---|---|
| `Esp a` | Añadir el archivo actual a la lista |
| `Ctrl+e` | Mostrar/ocultar menú de Harpoon |
| `Esp 1` a `Esp 4` | Abrir el archivo marcado en esa posición |
| `Esp hn` / `Esp hp` | Archivo marcado siguiente / anterior |

Úsalo para mantener a mano la implementación, su test y otro archivo de referencia sin buscarlos continuamente.

### Código y formato — LSP y Conform

Estos atajos LSP necesitan un servidor activo que soporte la operación en el archivo actual.

| Teclas | Acción |
|---|---|
| `gd` / `gD` | Ir a definición / declaración |
| `gi` | Ir a implementación |
| `gt` | Ir a definición de tipo |
| `gr` | Ver referencias |
| `K` | Documentación del símbolo bajo el cursor |
| `Esp rn` | Renombrar símbolo |
| `Esp ca` | Acciones de código |
| `Esp cd` | Diagnóstico flotante |
| `[d` / `]d` | Diagnóstico anterior / siguiente |
| `Esp cf` | Formatear; recurrir al LSP si no hay formateador disponible |

Servidores habilitados: `clangd` para C/C++; BasedPyright y Ruff para Python. Conform usa `clang-format` para C/C++ y `ruff_format` para Python. **No hay formato automático al guardar.**

`gt` está reasignado a definición de tipo; para cambiar de pestaña usa `Alt+.`.

### Problemas y símbolos — Trouble

| Teclas | Acción |
|---|---|
| `Esp xx` | Mostrar/ocultar diagnósticos del proyecto |
| `Esp xX` | Diagnósticos del buffer actual |
| `Esp cs` | Símbolos |
| `Esp cl` | Panel LSP de definiciones, referencias, etc. |
| `Esp xL` | Lista de ubicaciones |
| `Esp xQ` | Lista quickfix |

### Tests Python — Neotest

| Teclas | Acción |
|---|---|
| `Esp tt` | Ejecutar el test más cercano al cursor |
| `Esp tf` | Ejecutar los tests del archivo actual |
| `Esp ts` | Mostrar/ocultar árbol de tests |
| `Esp to` | Mostrar/ocultar panel de salida |
| `Esp tS` | Detener la ejecución cercana |

El único adaptador configurado es Python con `pytest`. Los atajos no añaden soporte para tests de otros lenguajes. Para probar otro proyecto, abre Neovim desde su raíz y asegúrate de que su entorno puede ejecutar pytest.

### Terminal integrada

Abre una terminal con `:terminal` o `:split | terminal`.

| Teclas en modo terminal | Acción |
|---|---|
| `Ctrl+g` | Salir del modo terminal sin detener el proceso |
| `Ctrl+h/j/k/l` | Salir del modo terminal y cambiar de ventana |
| `Alt+,` / `Alt+.` | Cambiar de pestaña |
| `Alt+1` a `Alt+4` | Ir a una pestaña concreta |

En modo normal sobre un buffer de terminal, `i` vuelve a enviar teclas al proceso. `Ctrl+g` no equivale a interrumpirlo con Ctrl+C.

## Cambios externos y seguridad al revisar

Los archivos sin ediciones locales se recargan al recuperar el foco, entrar en un buffer o salir del modo terminal. Si el agente y tú cambian el mismo archivo y tienes ediciones sin guardar, Neovim las conserva y puede mostrar una advertencia **W12**. Revisa ambas versiones antes de guardar: guardar tu buffer podría sobrescribir los cambios externos.

No hay un temporizador de refresco. Si permaneces dentro de una vista diff mientras el agente edita, usa `Esp gr`. También puedes ejecutar `:checktime` para comprobar cambios externos en archivos abiertos.

## Plugins incluidos

| Plugin | Función |
|---|---|
| lazy.nvim | Gestión de plugins y versiones |
| tokyonight.nvim | Tema de colores |
| neo-tree.nvim | Árbol de archivos y estado Git |
| gitsigns.nvim | Marcas y navegación de cambios por bloque |
| diffview.nvim | Diffs e historial Git |
| telescope.nvim | Búsquedas de archivos, texto, buffers y símbolos |
| harpoon (harpoon2) | Marcadores rápidos de archivos |
| smart-splits.nvim | Movimiento y tamaño de ventanas |
| nvim-lspconfig | Configuraciones de servidores de lenguaje |
| mason.nvim | Instalación manual de herramientas de desarrollo |
| conform.nvim | Formato de código |
| nvim-treesitter | Sintaxis para C, Lua, Vim, Vimdoc y Python; resaltado activado para C, Lua, Vim y Python |
| trouble.nvim | Paneles de diagnósticos y símbolos |
| neotest + neotest-python | Tests Python con pytest |
| which-key.nvim | Ayuda de atajos |

Dependencias auxiliares: plenary.nvim, nui.nvim, nvim-web-devicons, nvim-nio y FixCursorHold.nvim. No hay un plugin dedicado de autocompletado configurado.

## Dónde personalizar

| Ruta | Qué contiene |
|---|---|
| `init.lua` | Leader y carga de la configuración |
| `lua/config/options.lua` | Opciones generales y recarga externa |
| `lua/config/keymaps.lua` | Atajos generales y terminal |
| `lua/config/lazy.lua` | Arranque del gestor de plugins |
| `lua/plugins/` | Plugins, ajustes y sus atajos |
| `lazy-lock.json` | Versiones fijadas de plugins; conservar en Git |
| `tests/review.lua` | Prueba de humo del flujo de revisión |

Opciones actuales: números absolutos y relativos, indentación con espacios de ancho 4, portapapeles del sistema y ventanas nuevas a la derecha/abajo.

## Mantenimiento y diagnóstico

- `:Lazy`: consultar plugins. `:Lazy restore` recupera las versiones del lockfile; `:Lazy update` las actualiza y puede cambiarlo.
- `:Mason`: consultar e instalar herramientas externas. El lockfile de Lazy no fija sus versiones ni las de herramientas del sistema.
- `:checkhealth`: diagnosticar dependencias y problemas de configuración.
- `:checkhealth vim.lsp`: comprobar servidores de lenguaje; si falta uno, revisa Mason, PATH y el tipo de archivo.
- `:messages`: consultar errores o advertencias recientes.
- Si `Esp fg` falla, comprueba que `rg` esté instalado.
- Si no se descubren tests, revisa que pytest esté disponible en el Python del proyecto y que uses sus convenciones de nombres.
- Si los iconos son cuadros, configura una Nerd Font en tu terminal.

Para traer cambios de esta configuración a otra máquina, con el árbol de trabajo limpio:

```bash
git -C ~/.config/nvim pull --ff-only
```

Después abre Neovim, ejecuta `:Lazy restore` y reinícialo. Si Git detecta ediciones locales, revísalas antes de actualizar; no las descartes a ciegas.

## Verificar esta configuración

Desde `~/.config/nvim`, con los plugins instalados:

```bash
nvim --headless '+lua dofile("tests/review.lua")'
git diff --check
```

La prueba comprueba sintaxis Lua, atajos de revisión, conexión de Gitsigns, árboles, apertura/refresco/cierre de Diffview, paneles de Neotest y recarga externa sin perder ediciones locales. No ejecuta los tests de tus proyectos ni comprueba visualmente Lazygit. Una advertencia W12 durante la prueba es esperada: simula un conflicto con un buffer modificado.
