define CC6700_LATENCY = 3; # latency in [7.3ms, 20ms]

protocol bgp cc6700_v6 from dnpeers {
    neighbor fe80::3088:197 as 4242423088;
    interface "wg-peer-6700";

    ipv4 {
        import where dn42_import_filter(CC6700_LATENCY, BANDWIDTH, LINKTYPE);
        export where dn42_export_filter(CC6700_LATENCY, BANDWIDTH, LINKTYPE);
        extended next hop on;
    };

    ipv6 {
        import where dn42_import_filter_v6(CC6700_LATENCY, BANDWIDTH, LINKTYPE);
        export where dn42_export_filter_v6(CC6700_LATENCY, BANDWIDTH, LINKTYPE);
        extended next hop off;
    };
}
