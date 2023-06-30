using Primes


function a(n,k)
    (prime(n+1)-prime(n)==k) ? 1 : 0
end   

#=関数 Δ_k(x) = Σ_(1≤n≤x) a_k(n)=#
function Δ(x,k)
    gaps = []
    for i ∈ 1:x
        b = a(i,k)
        append!(gaps, b)
    end
    return sum(gaps)
end

function Dirichlet_sum(n)
    set = []
    for i ∈ 1:n
        (n%i==0) ? (append!(set,Δ(i,2))) : 0
    end
    return sum(set)
end

print(Dirichlet_sum(7))
