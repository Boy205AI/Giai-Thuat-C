#include <bits/stdc++.h>
using namespace std;
#define nl '\n'
#define ll long long 
const ll MOD = 1e9 + 7;

ll binPow(ll a, ll b, ll m = MOD) {
    ll res = 1;
    a %= m;
    while (b > 0) {
        if (b & 1) res = (res * a) % m;
        a = (a * a) % m;
        b >>= 1;
    }
    return res;
}

vector<bool> isPrime;
void sieve(int n) {
    isPrime.assign(n + 1, true);
    isPrime[0] = isPrime[1] = false;
    for (int i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i)
                isPrime[j] = false;
        }
    }
}

void segmentedSieve(long long L, long long R) {
    int limit = sqrt(R);
    sieve(limit); 
    
    vector<bool> mark(R - L + 1, true);
    if (L == 1) mark[0] = false;
    
    for (int i = 2; i <= limit; i++) {
        if (isPrime[i]) {
            
            long long firstMul = max(1LL * i * i, (L + i - 1) / i * i);
            for (long long j = firstMul; j <= R; j += i)
                mark[j - L] = false;
        }
    }
    // mark[i - L] == true ~ isPrime
}

void prefSum1D(int n, long long a[], long long p[]) {
    p[0] = 0;
    for (int i = 1; i <= n; i++) {
        p[i] = p[i - 1] + a[i];
    }
}

long long query1D(int l, int r, long long p[]) {
    return p[r] - p[l - 1];
}

long long p[1005][1005];

void prefSum2D(int n, int m, int a[][1005]) {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            p[i][j] = p[i - 1][j] + p[i][j - 1] - p[i - 1][j - 1] + a[i][j];
        }
    }
}

long long query2D(int x1, int y1, int x2, int y2) {
    return p[x2][y2] - p[x1 - 1][y2] - p[x2][y1 - 1] + p[x1 - 1][y1 - 1];
}

const int MAXN = 1e5 + 5;
vector<int> adj[MAXN];
bool visited[MAXN];

void dfs(int u) {
    visited[u] = true;
    
    for (int v : adj[u]) {
        if (!visited[v]) {
            dfs(v);
        }
    }
}

int dx[] = {-1, 1, 0, 0};
int dy[] = {0, 0, -1, 1};

bool visGrid[1005][1005];
void dfsGrid(int r, int c, int n, int m) {
    visGrid[r][c] = true;
    for (int i = 0; i < 4; i++) {
        int nr = r + dx[i];
        int nc = c + dy[i];
        
        if (nr >= 1 && nr <= n && nc >= 1 && nc <= m && !visGrid[nr][nc]) {
            dfsGrid(nr, nc, n, m);
        }
    }
}

void solve(){
  
}
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    
    solve();
    return 0;
}
