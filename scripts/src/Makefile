SOURCE = base.cpp

TARGETS = Simple/PE-Injector-Monolithic/ \
          Simple/PE-Injector/

# Generate action to run the generate script
generate:
	@echo "Running generate script with LHOST, HOSTNAME, LPORT..."
	@LHOST=$(LHOST) HOSTNAME=$(HOSTNAME) LPORT=$(LPORT) ./generate.sh
	@echo "Generate script executed successfully!"

# Copy the generated shellcode to the target directories
copy:
	@for dir in $(TARGETS); do \
		mkdir -p "$$dir"; \
		cp -v $(SOURCE) "$$dir"; \
	done

# The clean action
clean:
	@for dir in $(TARGETS); do \
		rm -f "$$dir""$(SOURCE)"; \
		echo "Deleted ""$$dir""$(SOURCE)"; \
	done
	@rm -f base.cpp base.dll
	@echo "Deleted root defined base.cpp and base.dll"

# Default target: run generate first, then copy the base.cpp file to all locations
all: generate copy
