#!/bin/bash

# Plugin Manager para Mod.sh - Sistema automático de plugins
# El usuario solo necesita poner el git clone y la URL

PLUGINS_DIR="./plugins"
PLUGINS_LIST="./plugins_list.txt"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ═══════════════════════════════════════════════════════════════════════════════
# Crear carpeta de plugins si no existe
# ═══════════════════════════════════════════════════════════════════════════════

[ ! -d "$PLUGINS_DIR" ] && mkdir -p "$PLUGINS_DIR"
[ ! -f "$PLUGINS_LIST" ] && touch "$PLUGINS_LIST"

# ═══════════════════════════════════════════════════════════════════════════════
# Cargar plugins automáticamente desde el archivo de lista
# ═══════════════════════════════════════════════════════════════════════════════

load_plugins() {
    # Leer archivo de lista y descargar plugins
    while IFS='|' read -r nombre url; do
        [ -z "$nombre" ] && continue
        
        plugin_path="$PLUGINS_DIR/$nombre"
        
        # Si no existe, clonar
        if [ ! -d "$plugin_path" ]; then
            echo -e "${BLUE}⬇ Clonando: ${YELLOW}$nombre${NC}"
            git clone "$url" "$plugin_path" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ $nombre instalado${NC}\n"
            else
                echo -e "${RED}✗ Error instalando $nombre${NC}\n"
            fi
        else
            # Actualizar si ya existe
            echo -e "${BLUE}⬆ Actualizando: ${YELLOW}$nombre${NC}"
            cd "$plugin_path"
            git pull 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ $nombre actualizado${NC}\n"
            fi
            cd - > /dev/null
        fi
    done < "$PLUGINS_LIST"
}

# ═══════════════════════════════════════════════════════════════════════════════
# Menú para agregar plugins
# ═══════════════════════════════════════════════════════════════════════════════

add_plugin_menu() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║      AGREGAR NUEVO PLUGIN             ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}\n"
    
    read -p "Nombre del plugin: " plugin_name
    read -p "URL (git clone): " plugin_url
    
    if [ -z "$plugin_name" ] || [ -z "$plugin_url" ]; then
        echo -e "${RED}✗ Datos incompletos${NC}"
        sleep 2
        return 1
    fi
    
    # Verificar que no existe en la lista
    if grep -q "^$plugin_name|" "$PLUGINS_LIST"; then
        echo -e "${RED}✗ El plugin ya está en la lista${NC}"
        sleep 2
        return 1
    fi
    
    # Agregar a la lista
    echo "$plugin_name|$plugin_url" >> "$PLUGINS_LIST"
    
    # Clonar ahora
    echo -e "${BLUE}⬇ Clonando: ${YELLOW}$plugin_name${NC}"
    git clone "$plugin_url" "$PLUGINS_DIR/$plugin_name" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✓ Plugin agregado correctamente${NC}"
        echo -e "Nombre: ${YELLOW}$plugin_name${NC}"
        echo -e "URL: ${BLUE}$plugin_url${NC}"
    else
        echo -e "${RED}✗ Error al clonar. Verifica la URL${NC}"
        sed -i "/^$plugin_name|/d" "$PLUGINS_LIST"
    fi
    
    sleep 3
}

# ═══════════════════════════════════════════════════════════════════════════════
# Ver plugins instalados
# ═══════════════════════════════════════════════════════════════════════════════

show_plugins() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║      PLUGINS INSTALADOS               ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}\n"
    
    if [ ! -s "$PLUGINS_LIST" ]; then
        echo -e "${YELLOW}⚠ No hay plugins agregados${NC}\n"
        read -p "Presiona ENTER para volver..."
        return 0
    fi
    
    local count=1
    while IFS='|' read -r nombre url; do
        [ -z "$nombre" ] && continue
        
        if [ -d "$PLUGINS_DIR/$nombre" ]; then
            echo -e "${GREEN}[$count]${NC} ${YELLOW}$nombre${NC}"
            echo -e "    ${BLUE}$url${NC}\n"
            count=$((count + 1))
        fi
    done < "$PLUGINS_LIST"
    
    read -p "Presiona ENTER para volver..."
}

# ═══════════════════════════════════════════════════════════════════════════════
# Actualizar todos los plugins
# ═══════════════════════════════════════════════════════════════════════════════

update_all() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║    ACTUALIZANDO TODOS LOS PLUGINS     ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}\n"
    
    if [ ! -s "$PLUGINS_LIST" ]; then
        echo -e "${YELLOW}⚠ No hay plugins para actualizar${NC}"
        sleep 2
        return 0
    fi
    
    while IFS='|' read -r nombre url; do
        [ -z "$nombre" ] && continue
        
        plugin_path="$PLUGINS_DIR/$nombre"
        if [ -d "$plugin_path" ]; then
            echo -e "${BLUE}⬆ Actualizando: ${YELLOW}$nombre${NC}"
            cd "$plugin_path"
            git pull 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Actualizado${NC}\n"
            else
                echo -e "${RED}✗ Error${NC}\n"
            fi
            cd - > /dev/null
        fi
    done < "$PLUGINS_LIST"
    
    echo -e "${GREEN}✓ Todos los plugins actualizados${NC}"
    sleep 2
}

# ═══════════════════════════════════════════════════════════════════════════════
# Eliminar plugin
# ═══════════════════════════════════════════════════════════════════════════════

remove_plugin() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║      ELIMINAR PLUGIN                  ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}\n"
    
    if [ ! -s "$PLUGINS_LIST" ]; then
        echo -e "${YELLOW}⚠ No hay plugins para eliminar${NC}"
        sleep 2
        return 0
    fi
    
    local count=1
    local -a plugins
    
    while IFS='|' read -r nombre url; do
        [ -z "$nombre" ] && continue
        plugins+=("$nombre")
        echo -e "${GREEN}[$count]${NC} $nombre"
        count=$((count + 1))
    done < "$PLUGINS_LIST"
    
    echo -e "${GREEN}[0]${NC} Cancelar\n"
    read -p "Selecciona plugin a eliminar: " choice
    
    if [ "$choice" -eq 0 ] 2>/dev/null; then
        return 0
    fi
    
    if [ "$choice" -ge 1 ] && [ "$choice" -le ${#plugins[@]} ] 2>/dev/null; then
        local plugin_name="${plugins[$((choice - 1))]}"
        read -p "¿Estás seguro de eliminar '$plugin_name'? (s/n): " confirm
        
        if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then
            rm -rf "$PLUGINS_DIR/$plugin_name"
            sed -i "/^$plugin_name|/d" "$PLUGINS_LIST"
            echo -e "\n${GREEN}✓ Plugin eliminado${NC}"
        else
            echo -e "${YELLOW}Cancelado${NC}"
        fi
    else
        echo -e "${RED}✗ Opción inválida${NC}"
    fi
    
    sleep 2
}

# ═══════════════════════════════════════════════════════════════════════════════
# Menú principal
# ═══════════════════════════════════════════════════════════════════════════════

main_menu() {
    while true; do
        clear
        echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║      GESTOR DE PLUGINS - MOD.SH      ║${NC}"
        echo -e "${CYAN}╚════════════════════════════════════════╝${NC}\n"
        
        echo -e "${GREEN}[1]${NC} Agregar plugin (git clone + URL)"
        echo -e "${GREEN}[2]${NC} Ver plugins instalados"
        echo -e "${GREEN}[3]${NC} Actualizar todos"
        echo -e "${GREEN}[4]${NC} Eliminar plugin"
        echo -e "${GREEN}[5]${NC} Cargar/Sincronizar plugins"
        echo -e "${RED}[0]${NC} Salir\n"
        
        read -p "Opción: " option
        
        case $option in
            1) add_plugin_menu ;;
            2) show_plugins ;;
            3) update_all ;;
            4) remove_plugin ;;
            5) clear; echo -e "${BLUE}Sincronizando plugins...${NC}\n"; load_plugins; read -p "Presiona ENTER..." ;;
            0) clear; exit 0 ;;
            *) echo -e "${RED}✗ Opción inválida${NC}"; sleep 1 ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
# Ejecutar
# ═══════════════════════════════════════════════════════════════════════════════

main_menu
