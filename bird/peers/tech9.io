protocol bgp tech9 from dnpeers {
        neighbor 172.20.16.141 as 4242421588;
}

protocol bgp tech9_v6 from dnpeers {
        neighbor fe80::1588 as 4242421588;
        interface "wg-peer-tech9";
}
