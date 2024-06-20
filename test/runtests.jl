using EGGroupMakie
using Test
using CairoMakie

function makefigure()
    fig = EGGroupMakie.skeleton(
        title="This is a title",
        subtitle="This is a very long subtitle, which should even be so long that it wraps around and needs to spill over to the next line. Actually, I think it needs to be even longer to spill for a full-width slide.",
        caption="Source: PATSTAT or something, as always",
    )
    gl = GridLayout(fig[1, 1])
    ax = Axis(gl[2, 1])
    for i in 1:3
        scatter!(ax, rand(100); label=string(i))
    end
    EGGroupMakie.TopLegend(gl[1, 1], ax)
    fig
end

@testset "EGGroupMakie.jl" begin

end
