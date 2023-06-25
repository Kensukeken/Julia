function plot_integral_curve(f, x0, y0, tspan)
  # Create a grid of points in the domain of the integral curve.
  x = range(x0, stop=x0 + tspan[2], length=100)
  y = range(y0, stop=y0 + tspan[2], length=100)
  # Evaluate the vector field at each point in the grid.
  fx = f(x, y)
  fy = f(y, x)
  # Plot the integral curve as a set of lines.
  plot(x, y, color=:black)
  # Plot the vector field as a set of arrows.
  quiver(x, y, fx, fy)
end
function f(x, y)
  return [2x, 2y]
end
plot_integral_curve(f, 1, 1, [0, 1])
