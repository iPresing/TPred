#!/bin/bash

# Fonction pour afficher le menu
function afficher_menu {
    clear
    echo "1. apt upgrade"
    echo "2. apt update"
    echo "3. network-manager removal"
    echo "4. STATIC automatic configuration"
    echo "5. apache2 install"
    echo "6. cdrom error fix tool"
    echo "0. Quitter"
    echo ""
}

# Boucle principale pour le menu :)
while true
do
    afficher_menu
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            # apt upgrade
            sudo apt upgrade -y
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        2)
            # apt update
            sudo apt update -y
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        3)
            # network-manager removal
            sudo apt remove network-manager -y
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        4)
            # STATIC automatic configuration
            echo "Interfaces disponibles : "
            ip a | grep "^[0-9]" | awk '{print $2}' | awk -F: '{print $1}'
            read -p "Entrez le nom de l'interface : " interface
            read -p "Entrez l'adresse IP (0 pour ne rien mettre) : " address
            read -p "Entrez le masque de sous-réseau (0 pour ne rien mettre) : " netmask
            read -p "Entrez la passerelle par défaut (0 pour ne rien mettre) : " gateway
            read -p "Entrez le serveur de noms (0 pour ne rien mettre) : " nameserver

            echo "auto $interface
            iface $interface inet static
            address ${address:-0}
            netmask ${netmask:-0}
            gateway ${gateway:-0}
            dns-nameservers ${nameserver:-0}" | sudo tee /etc/network/interfaces >/dev/null

            sudo systemctl restart networking
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        5)
            # apache2 install
            sudo apt install apache2 -y
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        6)
            # cdrom error fix tool
            sudo sed -i '/^deb cdrom:/s/^/#/' /etc/apt/sources.list
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
        0)
            # Quitter
            exit 0
            ;;
        *)
            # Choix invalide
            echo "Choix invalide."
            read -p "Appuyez sur une touche pour continuer ..."
            ;;
    esac
done
