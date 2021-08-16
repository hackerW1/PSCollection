#!/usr/bin/python3

import sys
import os
import socket

def usage_reminder():
    print("Usage: ./pscanner.py <host> <port>")
    print("\tExample: ./pscanner.py google.com 443")
    print("\nUsage: ./pscanner.py <host> <port-range>")
    print("\tExample: ./pascanner.py google.com 22-443")


def porto(port):
    if(port.isnumeric()):
        return int(port)
    elif("-" in port):
        r = port.split("-",1)
        return range(int(r[0]),int(r[1])+1)
    else:
        raise SystemExit("Please input a valid port number [0 - 65535]")


def scan_port(ip, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(0.7)
    result = sock.connect_ex((ip,port))
    if not result:
        print(f"Discovered open port {port}")
    sock.close()

def main():
    try:
        HOST = sys.argv[1]
        PORT = sys.argv[2]
        if len(sys.argv) == 3:
            try:
                TARGET = socket.gethostbyname(HOST)
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                sock.settimeout(0.7)
                PORTS = porto(PORT)
            
                if isinstance(PORTS, int):
                    scan_port(TARGET, PORTS)
                elif isinstance(PORTS, range):
                    for _port in PORTS:
                        scan_port(TARGET, _port)
            
                print("[+] Completed")
        
            except KeyboardInterrupt:
                print("\n[+] Quited!!")
                exit(1)
        
            except ValueError:
                print("\nPlease enter a valid port number")

            except socket.gaierror:
                print("\nHost name is invalid")
        
            except socket.error:
                print("\nCouldn't connect to the HOST")

        else:
            usage_reminder()
    
    except IndexError:
        usage_reminder()


if __name__ == '__main__':
    main()