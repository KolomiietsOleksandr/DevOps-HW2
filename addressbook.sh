#!/bin/bash

ADDRESS_BOOK="addressbook.txt"

add_contact() {
    echo "Enter Name:"
    read name
    echo "Enter Phone Number:"
    read phone
    echo "Enter Email:"
    read email

    echo "$name:$phone:$email" >> "$ADDRESS_BOOK"
    echo "Contact added successfully."
}

search_contact() {
    echo "Enter search term (name, phone, or email):"
    read search_term

    result=$(grep -i "$search_term" "$ADDRESS_BOOK")

    if [ -z "$result" ]; then
        echo "No contacts found."
    else
        echo "Matching contacts:"
        echo "$result" | while IFS= read -r line; do
            name=$(echo "$line" | cut -d':' -f1)
            phone=$(echo "$line" | cut -d':' -f2)
            email=$(echo "$line" | cut -d':' -f3)
            echo "Name: $name, Phone: $phone, Email: $email"
        done
    fi
}

remove_contact() {
    echo "Enter name, phone, or email to remove:"
    read search_term

    if grep -q -i "$search_term" "$ADDRESS_BOOK"; then
        sed -i "" "/$search_term/Id" "$ADDRESS_BOOK"
        echo "Contact removed."
    else
        echo "No contact found with that information."
    fi
}

case "$1" in
    add)
        add_contact
        ;;
    search)
        search_contact
        ;;
    remove)
        remove_contact
        ;;
    *)
        echo "Usage: $0 {add|search|remove}"
        ;;
esac
