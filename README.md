# Fractal typography

This project implements a [Sierpinski carpet](https://en.wikipedia.org/wiki/Sierpinski_carpet) using LaTeX. 

To start, install `pdflatex` and `pdfcrop` and run

    python build_recursion.py

It first compiles the "source" image. 
You can make your custom image by modifying [source.tex](source.tex). 
Next to implements the Sierpinski ["template"](table.tex)

    \newcommand{\A}{\includegraphics[width=50cm]{pdf/source.pdf}}

    ...

    \begin{tabular}{lll}
    \A & \A & \A\\
    \A &    & \A\\
    \A & \A & \A
    \end{tabular}

and rebuilds each level by reusing the previous compilation. 
A few iterations (1,2,3,4,5, and 999) can be found in the [pdf directory](pdf).

## Examples

**Level 1** (source image)
![](figures/s1.png)

**Level 2** (8 copies)
![](figures/s2.png)

**Level 3** (512 copies)
![](figures/s3.png)

**Level 4** (4096 copies)
![](figures/s4.png)

**Level 5** (32768 copies)
![](figures/s5.png)

---------

**Level 999** (8^999 copies)
[Good luck!](pdf/level_999.pdf)


### Website

Visit the project website at: https://drlensi.github.io/fractal_typography/

### Presentation

http://thoppe.github.io/fractal_typography/HnT_index.html#/

First presented at [DC Hack && Tell Round 27: Hyperion Christmas Carols](https://www.meetup.com/DC-Hack-and-Tell/events/220231803/).

