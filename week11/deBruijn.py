#! /usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
graph = set()
k=3

for read in reads:
  for i in range(len(read) - k):
     kmer1 = read[i: i+k]
     kmer2 = read[i+1: i+1+k]
     graph.add((kmer1, kmer2))


with open("debruijn.dot", "w") as f:
    f.write("digraph G {\n")
    for a, b in sorted(graph):
        f.write(f'"{a}" -> "{b}";\n')
    f.write("}\n")