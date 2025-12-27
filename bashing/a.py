import heapq
import itertools

lim = 1000000

# Prime sieve & totient generator
def sieve():
    yield 2
    h = []
    heapq.heappush(h,(4,2))
    i = 3
    while True:
        if h[0][0] > i:
            heapq.heappush(h, (i*i,i))
            yield i
            i += 1
        if h[0][0] == i:
            while h[0][0] == i:
                a = h[0]
                heapq.heappushpop(h, (a[0]+a[1], a[1]))
            i += 1

tot = []
invtot = {}

# Prime sieve & totient generator
def gen():
    global tot, invtot
    tot = [0,1,1]
    h = []
    heapq.heappush(h,(4,2))
    invtot.setdefault(0,[]).append(0)
    invtot.setdefault(1,[]).append(1)
    invtot.setdefault(1,[]).append(2)
    i = 3
    while i <= 1000000:
        if h[0][0] > i:
            # i is prime! tot(i) = i - 1
            heapq.heappush(h, (i*i,i))
            tot.append(i-1)
            invtot.setdefault(tot[-1],[]).append(i)
        if h[0][0] == i:
            # i = h[0][0] is divisible by h[0][1]. h[0][1] is prime by invariant
            # tot(p i/p) is p tot(i/p) if i/p is divisible by p already
            # otherwise it's (p-1) tot(i/p)
            tot.append((h[0][1] if i % (h[0][1] ** 2) == 0 else h[0][1] - 1)*tot[i // h[0][1]])
            invtot.setdefault(tot[-1],[]).append(i)
            while h[0][0] == i:
                a = h[0]
                heapq.heappushpop(h, (a[0]+a[1], a[1]))
        i += 1
    return tot

def gendeps(i,k):
    nodes = [i]
    if i % k != 0:
        return ([i],[])
    ip = i // k
    edges = []
    for j in invtot.setdefault(ip,[]):
        edges.append((j,i))
        if j == i:
            continue
        (jnodes, jedges) = gendeps(j,k);
        nodes += jnodes
        edges += jedges
    return (nodes, edges)

def gendeps_vis(i,k):
    (nodes, edges) = gendeps(i,k);
    return "\n".join(itertools.chain(map(str,nodes),map(lambda i: str(i[0]) + " " + str(i[1]),edges)))

try:
    with open("a.txt","r") as f:
        tot = list(map(int,f.read().split("\n")))
    lim = len(tot) - 1
    for i in range(0, len(tot)):
        invtot.setdefault(tot[i],[]).append(i)
except:
    print("whoops. generating")
    gen()
    with open("a.txt","w") as f:
        f.write("\n".join(map(str,tot)))

