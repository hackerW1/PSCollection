package main

import (
	"fmt"
	"net"
	"sort"
)

func worker(ports, results chan int) {
	for p := range ports {
		address := fmt.Sprintf("scanme.nmap.org:%d", p)
		conn, err := net.Dial("tcp", address)
		if err != nil {
			results <- 0
			continue
		}
		conn.Close()
		results <- p
	}
}

func main() {
	// this channel will receive ports to be scanned
	ports := make(chan int, 100)
	// this channel will receive results of scanning
	results := make(chan int)
	// create a slice to store the results so that they can be sorted later.
	var openports []int

	// create a pool of workers
	for i := 0; i < cap(ports); i++ {
		go worker(ports, results)
	}

	// send ports to be scanned
	go func() {
		for i := 1; i <= 1024; i++ {
			ports <- i
		}
	}()

	for i := 0; i < 1024; i++ {
		port := <-results
		if port != 0 {
			openports = append(openports, port)
		}
	}

	// After all the work has been completed, close the channels
	close(ports)
	close(results)
	// sort open port numbers
	sort.Ints(openports)
	for _, port := range openports {
		fmt.Printf("%d open\n", port)
	}
}
