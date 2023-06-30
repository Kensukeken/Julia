#パッケージ
using Primes
using Plots

#変数
N= 2000
G = 2
G2 = 4
G3 = 6

#=関数 a_k(x) : p_(n+1) - p(n) = k, k ∈ N
              : 0 そうでなければ
=#
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

#グラフ#
begin
    xval = []
    for i ∈ 1:N
       push!(xval,i)
    end

    yval = []
    for i ∈ 1:N
       push!(yval,Δ(i,G))
    end

    gap4 = []
    for i ∈ 1:N
        push!(gap4,Δ(i,G2))
    end

    gap6 = []
    for i ∈ 1:N
        push!(gap6,Δ(i,G3))
    end

    y = @. xval/log.(xval)
    theme(:dracula)
    display(plot(xval,[yval,y,gap4,gap6], label = ["Δ_2(x)" "x/log(x)" "Δ_4(x)" "Δ_6(x)"]))

    readline()
end
