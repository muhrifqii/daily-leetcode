# General Configuration
DAILY_DIR := daily

# Language-specific executables
JAVA_EXEC := java
KOTLIN_EXEC := kotlinc
CPP_EXEC := g++
GO_EXEC := go
RUST_EXEC := cargo
PYTHON_EXEC := python3
ELIXIR_EXEC := elixir

# Use DATE as the environment variable for the date format YYYY-MM-DD
DATE := $(date)
YEAR := $(shell echo $(DATE) | cut -d- -f1)
MONTH := $(shell echo $(DATE) | cut -d- -f2)
DAY := $(shell echo $(DATE) | cut -d- -f3)
DAILY_PATH := $(DAILY_DIR)/$(YEAR)/$(MONTH)/$(DAY)

# Solution file pattern, e.g., solution01.java, solution02.java, etc.
SOLUTION_PATTERN := *olution*

# Temporary output file for diff check
OUTPUT_FILE := output.txt

# Helper function to run solution and compare with expected output
define RUN_SOLUTION
	@for file in $(DAILY_PATH)/$(SOLUTION_PATTERN).$(1); do \
		echo "Running $$file..."; \
		$(2) $$file < $(DAILY_PATH)/input.txt > $(OUTPUT_FILE) 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "Execution failed for $$file, see errors:"; \
			cat $(OUTPUT_FILE); \
			exit 1; \
		fi; \
		if ! diff -y $(OUTPUT_FILE) $(DAILY_PATH)/expected.txt; then \
			echo "Output differs for $$file"; \
			exit 1; \
		else \
			echo "Test cases passed for $$file"; \
		fi; \
	done
endef

clean-output:
	@ rm -f $(OUTPUT_FILE)

# Java solutions (using Java 21 single-file execution)
java: clean-output
	$(call RUN_SOLUTION,java,$(JAVA_EXEC))

# C++ solutions
cpp: clean-output
	@for file in $(DAILY_PATH)/$(SOLUTION_PATTERN).cpp; do \
		echo "Compiling $$file..."; \
		$(CPP_EXEC) $$file -o $(DAILY_PATH)/$$(basename $$file .cpp).out || exit 1; \
		$(DAILY_PATH)/$$(basename $$file .cpp).out < $(DAILY_PATH)/input.txt > $(OUTPUT_FILE) 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "Execution failed for $$file, see errors:"; \
			cat $(OUTPUT_FILE); \
			rm -f $(DAILY_PATH)/$$(basename $$file .cpp).out; \
			exit 1; \
		fi; \
		if ! diff -y $(OUTPUT_FILE) $(DAILY_PATH)/expected.txt; then \
			echo "Output differs for $$file"; \
			rm -f $(DAILY_PATH)/$$(basename $$file .cpp).out; \
			exit 1; \
		else \
			echo "Test cases passed for $$file"; \
			rm -f $(DAILY_PATH)/$$(basename $$file .cpp).out; \
		fi; \
	done

# Go solutions
go: clean-output
	$(call RUN_SOLUTION,go,$(GO_EXEC) run)

# Rust solutions
rust: clean-output
	@for file in $(DAILY_PATH)/$(SOLUTION_PATTERN).rs; do \
		echo "Running $$file..."; \
		cd $(DAILY_PATH) && $(RUST_EXEC) run --quiet < input.txt > $(OUTPUT_FILE) 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "Execution failed for $$file, see errors:"; \
			cat $(OUTPUT_FILE); \
			exit 1; \
		fi; \
		if ! diff -y $(OUTPUT_FILE) expected.txt; then \
			echo "Output differs for $$file"; \
			exit 1; \
		else \
			echo "Test cases passed for $$file"; \
		fi; \
	done

# Python solutions
python: clean-output
	$(call RUN_SOLUTION,py,$(PYTHON_EXEC))

# Elixir solutions
elixir: clean-output
	$(call RUN_SOLUTION,exs,$(ELIXIR_EXEC))

