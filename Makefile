all:
	
clean:
	
install:
	@chmod +x pscanner.*
	@go build go/pscanner.go
	@echo "[+] Installed"
	@echo "Run Any of them by:"
	@echo "   ./pscanner.py"
	@echo "   ./pscanner.rb <host> <port>"
	@echo "   ./pscanner"
