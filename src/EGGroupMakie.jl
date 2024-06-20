module EGGroupMakie

using Makie: Label, Axis, Theme, Figure, GridLayout, Legend, with_theme
using Makie.ColorSchemes: colorschemes

const COLORMAP = colorschemes[:tableau_10].colors

const SIZE_FULL = (1920, 1080)
const SIZE_HALF = (960, 1080)
const SIZE_TWO_THIRDS = (1280, 1080)
const SIZE_60 = (1152, 1080)

const WRAPSIZE = Dict(SIZE_FULL => 135)

function ThemePPT()
    Theme(
        size=(1920, 1080),
        fontsize=24,
        figure_padding=(60, 100, 30, 30),
        backgroundcolor="#f3f0eb",
        justification=:left,
        Axis=(titlecolor=:grey20, titlealign=:left, titlesize=30, titlefont=:bold),
        Legend=(marker=:rect, markersize=28,),
    )
end

function Title(gp, text; kwargs...)
    Label(gp;
        text,
        color=:grey30,
        font=:bold,
        fontsize=55,
        halign=:left,
        tellwidth=false,
        kwargs...)
end

function Subtitle(gp, text; kwargs...)
    Label(gp;
        text,
        color=:grey20,
        fontsize=30,
        lineheight=1.1,
        padding=(0, 0, 20, 0),
        halign=:left,
        justification=:left,
        tellwidth=false,
        kwargs...)
end

function Caption(gp, text; kwargs...)
    Label(gp;
        text,
        color=:grey50,
        font=:italic,
        fontsize=20,
        lineheight=1.1,
        padding=(0, 0, 0, 30),
        tellwidth=false,
        halign=:right,
        kwargs...)
end

function AxLabel(gp, text; kwargs...)
    Label(gp;
        text,
        color=:black,
        font=:bold,
        fontsize=30,
        tellwidth=false,
        tellheight=false,
        kwargs...)
end

function TopLegend(gp, args...; kwargs...)
    Legend(gp, args...;
        orientation=:horizontal,
        tellwidth=false,
        halign=:left,
        marker=:rect,
        markersize=28,
        backgroundcolor=:transparent,
        framevisible=false,
        kwargs...)
end

function skeleton(;
    title=nothing,
    subtitle=nothing,
    caption=nothing,
    size=SIZE_FULL,
    theme=ThemePPT(),
)

    fig = with_theme(theme) do
        fig = Figure(; size)
        isnothing(subtitle) || Subtitle(fig[begin-1, 1], wrap(subtitle, WRAPSIZE[size]))
        isnothing(title) || Title(fig[begin-1, 1], uppercase(title))
        isnothing(caption) || Caption(fig[end+1, 1], caption)
        fig
    end

    fig
end

function wrap(str::AbstractString, maxlen=92; trim=Inf)
    str = foldl(((k, s), w) -> (k += m = length(w *= " ")) > maxlen + 1 ?
                               (m, s * "\n" * w) : (k, s * w), split(str); init=(0, ""))[2]

    if length(str) > trim
        str = first(str, trim)
        str *= "..."
    end

    str
end

# function legend!(pos, elems;
#     marker=:rect,
#     markersize=28,
#     backgroundcolor=:transparent,
#     framevisible=false,
#     kwargs...
# )
#
#     cm = Dict(COLORMAP)
#     lm = Dict(DUC)
#     es = [MarkerElement(; color=cm[v], marker, markersize) for v in elems]
#     Legend(pos, es, [lm[v] for v in elems]; backgroundcolor, framevisible, kwargs...)
#     return
# end

# function displayplot(fig; ft="svg")
#     file = tempdir() * "/test." * ft
#     save(file, fig)
#     run(`wslview $file`)
# end

# function limit_region!(ax, region::String)
#     region in keys(MAPLIMITS) || error("Limits not specified for region $region")
#     lims = MAPLIMITS[region]
#     xlims!(ax, lims.xlims...)
#     ylims!(ax, lims.ylims...)
#     return
# end

# function enrich_label(str; wrap_at=nothing)
#     str = isnothing(wrap) ? str : wrap(str, wrap_at)
#     tokens = map(split(str, " ")) do t
#         m = match(r"\([A-Z]\)", t)
#         if isnothing(m)
#             return rich(string(t * " "))
#         else
#             return rich(string(t * " "); font=:bold)
#         end
#     end
#     rich(tokens...)
# end

end
