using Plots

# Function to check if a point is in the Mandelbrot set
function mandelbrot(a)
    z = a
    for i=1:1000
        if abs(z) > 1000
            return i-1
        end
        z = z*z + a
    end
    return 1000
end

# Generate an array representing the Mandelbrot set
mandelbrot_set = [mandelbrot(complex(r, i)) for i=-1:0.005:1, r=-2:0.005:1]

# Display the Mandelbrot set
heatmap(mandelbrot_set, color=:inferno)
