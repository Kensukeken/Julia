function calculator()
    println("Welcome to the Julia Calculator")

    while true
        println("Please enter the operation (+, -, *, /) or 'quit' to exit:")
        op = readline()

        if op == "quit"
            break
        elseif op in ["+", "-", "*", "/"]
            println("Enter the first number:")
            num1 = parse(Float64, readline())
            println("Enter the second number:")
            num2 = parse(Float64, readline())

            if op == "+"
                result = num1 + num2
            elseif op == "-"
                result = num1 - num2
            elseif op == "*"
                result = num1 * num2
            elseif op == "/"
                if num2 == 0
                    println("Error: Division by zero is not allowed.")
                    continue
                else
                    result = num1 / num2
                end
            end

            println("The result is $result")
        else
            println("Invalid operation. Please enter +, -, *, / or 'quit'.")
        end
    end
end

calculator()
