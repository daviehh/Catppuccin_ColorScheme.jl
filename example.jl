using ColorSchemes
using CairoMakie

include("catppuccin_scheme.jl")

x = range(0, π, 300)

let
    fig = Figure()
    ax = Makie.Axis(fig[1, 1])

    for (i, v) in enumerate(ColorSchemes.colorschemes[:catppuccin_mocha])
        y = @. cos(x + i)
        lines!(x, y; color=v)
    end
    save("example_mocha.png", fig)
    fig
end
