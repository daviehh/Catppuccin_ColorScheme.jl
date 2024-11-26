using JSON
using ColorSchemeTools, Colors

# https://github.com/catppuccin/catppuccin/blob/main/LICENSE
# MIT License

# Copyright (c) 2021 Catppuccin

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# https://github.com/catppuccin/palette/blob/main/palette.json
d = JSON.parsefile("palette.json")

function parse_colors(d, n)
    data = d[n]["colors"]
    c = [parse(Colorant, v["hex"]) for (_, v) in data]
    idx = sortperm([v["order"] for (_, v) in data])
    c[idx]
end

color_palette_ns = ["latte", "frappe", "macchiato", "mocha"]

# https://github.com/JuliaGraphics/ColorSchemeTools.jl/blob/630c3ac8d57c5408cd19cf072904c97245409f57/src/ColorSchemeTools.jl#L242

open("catppuccin_scheme.jl", "w") do fhandle
    for clrs in color_palette_ns

        cs = parse_colors(d, clrs)
        schemename = "Catppuccin_$clrs"
        category = "Catppuccin"
        notes = "Catppuccin theme: $clrs flavor."

        write(fhandle, string("loadcolorscheme(:$(schemename), [\n"))
        for c in cs
            color_str = string("\t$(c), \n")
            write(fhandle, color_str)
        end
        write(fhandle, string("], \"$(category)\", \"$(notes)\")"))

        write(fhandle, "\n\n")
    end
end