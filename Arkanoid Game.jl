using Pkg
Pkg.add("GLFW")
Pkg.add("GL")

using GLFW
using GL

# Constants
const window_width = 800
const window_height = 600
const paddle_width = 100
const paddle_height = 20
const ball_radius = 10

# Initial paddle position
paddle_x = (window_width - paddle_width) ÷ 2
paddle_y = 30

# Initial ball position and velocity
ball_x = window_width ÷ 2
ball_y = window_height ÷ 2
ball_speed_x = 5
ball_speed_y = 5

function draw_paddle()
    glBegin(GL_QUADS)
    glVertex2f(paddle_x, paddle_y)
    glVertex2f(paddle_x + paddle_width, paddle_y)
    glVertex2f(paddle_x + paddle_width, paddle_y + paddle_height)
    glVertex2f(paddle_x, paddle_y + paddle_height)
    glEnd()
end

function draw_ball()
    glBegin(GL_TRIANGLE_FAN)
    for i in 0:360
        angle = deg2rad(i)
        glVertex2f(ball_x + ball_radius * cos(angle), ball_y + ball_radius * sin(angle))
    end
    glEnd()
end

function update()
    # Update ball position
    ball_x += ball_speed_x
    ball_y += ball_speed_y

    # Check for collision with walls
    if ball_x - ball_radius < 0 || ball_x + ball_radius > window_width
        ball_speed_x *= -1
    end
    if ball_y - ball_radius < 0 || ball_y + ball_radius > window_height
        ball_speed_y *= -1
    end

    # Check for collision with paddle
    if (
        ball_x + ball_radius > paddle_x &&
        ball_x - ball_radius < paddle_x + paddle_width &&
        ball_y - ball_radius < paddle_y + paddle_height
    )
        ball_speed_y *= -1
    end
end

function key_callback(window, key, scancode, action, mods)
    if action == GLFW.PRESS || action == GLFW.REPEAT
        if key == GLFW.KEY_LEFT && paddle_x > 0
            paddle_x -= 10
        elseif key == GLFW.KEY_RIGHT && paddle_x + paddle_width < window_width
            paddle_x += 10
        end
    end
end

# Set up GLFW window
glfwInit()
window = glfwCreateWindow(window_width, window_height, "Julia Arkanoid", nothing, nothing)
glfwMakeContextCurrent(window)
glViewport(0, 0, window_width, window_height)
glfwSetKeyCallback(window, key_callback)

# Main game loop
while !glfwWindowShouldClose(window)
    glClear(GL_COLOR_BUFFER_BIT)

    # Update and draw
    update()
    draw_paddle()
    draw_ball()

    glfwSwapBuffers(window)
    glfwPollEvents()
end

# Clean up
glfwDestroyWindow(window)
glfwTerminate()
