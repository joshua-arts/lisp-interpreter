class Lisp

    @@symbols = ['+', '-', '*', '/', 'max', 'min', 'rem', 'abs', 'eq?', 'define']

    @@defintions = {}

    @@operation_limits = {
        'abs' => 1,
        'rem' => 2,
        'eq?' => 2,
        'define' => 2}

    # Convert a lisp string into tokens.
    def tokenize(s)
        s.gsub!('(', ' ( ').gsub!(')', ' ) ').split()
    end

    def get_bounds(arr)
        starts = arr.each_index.select{|i| arr[i] == '('}.reverse!
        ends = arr.each_index.select{|i| arr[i] == ')'}

        bounds = []
        starts.length.times{ |i|
            bounds << [starts[i], ends[i]]
        }

        bounds
    end

    # Groups tokens into array expressions.
    def group_expressions(tokens)

        bounds = get_bounds(tokens)
        mod = 1

        bounds.each_with_index{ |bound, i|
            exp = tokens[(bound[0] + 1)..(bound[1] - mod)]
            sliced = tokens.slice!(bound[0]..(bound[1] - mod))
            tokens[bound[0]] = exp
            mod += sliced.length
        }

        tokens[0]
    end

    # Checks if an array contains another array.
    def contains_array?(arr)
        arr.each_with_index{ |e, i|
            return i if e.class == Array
        }
        -1 # Doesn't contain array.
    end

    # Checks if a lisp method is taking the correct amount of arguments.
    def check(func, given)
        return unless @@operation_limits.has_key?(func)
        if given != @@operation_limits[func] then
            puts "Error: #{func} must only take #{@@operation_limits[func]} argument(s)."
            raise
        end
    end

    # Converts an array to a lisp list.
    def lispify(list)
        l = "("
        list.each{ |e| l += "#{e} " }
        l = l[0..-2]
        l += ')'
        l
    end

    # Applies definitions to the args.
    def apply_definitions(args)
        n = []
        args.each{ |e|
            e =  @@defintions[e] if @@defintions.has_key?(e)
            n << e
        }
        n
    end

    # Evaluates a simple lisp expression.
    # NOTE: Shorten this with lamdas.
    def evaluate(exp)
        op, *args = exp
        check(op, args.length)
        args = apply_definitions(args)
        if op == 'max' then
            args.map!(&:to_i).max
        elsif op == 'min' then
            args.map!(&:to_i).min
        elsif op == 'abs' then
            args[0].to_i.abs
        elsif op == 'rem' then
            args[0].to_i % args[1].to_i
        elsif op == 'eq?' then
            args[0].to_i == args[1].to_i
        elsif op == "define" then
            @@defintions[args[0]] = args[1]
            return "#{args[0]} defined as #{args[1]}"
        elsif @@symbols.include?(op)
            args.map!(&:to_i).inject(&op.to_sym)
        else
            # Must be a basic lisp list, so we don't eval.
            lispify(args.unshift(op))
        end
    end

    # Recursively evaluates a lisp sequence.
    def compute(a)
        ind = contains_array?(a)
        a[ind] = compute(a[ind]) if ind > 0
        return evaluate(a)
    end

    # General method to interpret lisp from a string.
    def interpret(str)
        begin
            compute(group_expressions(tokenize(str)))
        rescue
            "Invalid Lisp syntax."
        end
    end

end
