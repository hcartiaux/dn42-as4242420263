# Output settings
set terminal pngcairo size 1000,600 enhanced font 'Verdana,14'
set output 'dn42_ranking.png'

# Time axis configuration
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m"
set xtics rotate by -45
set grid xtics ytics ls 12 lc rgb '#dddddd' lt 1

set title "AS4242420263 Evolution: Peer Count vs. Rank position"
set xlabel "Date"

# Left Y Axis (y1): Peers
set ylabel "Number of Peers" tc rgb "gray10"
set ytics nomirror tc rgb "gray10"
set yrange [0:100]

# Right Y Axis (y2): Position (Rank)
set y2label "Rank Position" tc rgb "blue"
set y2tics nomirror tc rgb "blue"
# We invert the y2 axis so that "climbing the ranks" looks like an upward trend
set y2range [201:1]

# Legend setup
set key outside bottom center horizontal

# Vertical line for release date
set arrow from "2025-04-17", graph 0 to "2025-04-17", graph 1 nohead dt 2 lc rgb "red"

# Label for the line
set label "  Autopeering service release" at "2025-04-17", graph 0.95 left tc rgb "red"

# Add labels for final values on the axes
# Replace these values with your actual final data points
# final_peers = 78
final_rank = 22

# set ytics add (sprintf("%d", final_peers) final_peers)
set y2tics add (sprintf("%d", final_rank) final_rank)

# Plotting
# Peers (col 3) on x1y1
# Position (col 2) on x1y2
plot 'dn42_ranking.dat' using 1:3 axes x1y1 with linespoints lw 2 pt 5 lc rgb "gray10" title "Peers (Left Axis)", \
     'dn42_ranking.dat' using 1:2 axes x1y2 with linespoints lw 2 pt 7 lc rgb "blue" title "Rank Position (Right Axis)"
