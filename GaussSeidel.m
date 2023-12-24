function GaussSeidel()
    tolerance = 5;
    old = [0, 0, 0]; % store x old values initial values will be placed here
    i = 1;
    x1 = [];
    x2 = [];
    x3 = [];

    % store every relative error for each x
    e1 = [];
    e2 = [];
    e3 = [];

    %matrix after doing diagonal domanance to insure convergance
    m = [6 -1 4;
        5 7 -6;
        4 -5 9;]; %coffeciants 

    b = [9 -5 6;]; % results matrix
    
    while true
        new = compute_x([], old, m, b);

        % calculate relative error
        err_x1 = round(abs((new(1) - old(1))/new(1)) * 100, 4);
        err_x2 = round(abs((new(2) - old(2))/new(2)) * 100, 4);
        err_x3 = round(abs((new(3) - old(3))/new(3)) * 100, 4);

        % save results
        x1 = [x1, new(1)];
        x2 = [x2, new(2)];
        x3 = [x3, new(3)];
        e1 = [e1, err_x1];
        e2 = [e2, err_x2];
        e3 = [e3, err_x3];

        if err_x1 <= tolerance && err_x2 <= tolerance && err_x3 <= tolerance
            break;
        end

        % continue
        old = new;
        i = i + 1;
    end

     % Print the arrays and iteration count
    disp('x1:');
    disp(x1);
    disp('x2:');
    disp(x2);
    disp('x3:');
    disp(x3);
    disp('e1:');
    disp(e1);
    disp('e2:');
    disp(e2);
    disp('e3:');
    disp(e3);
    
    disp(['Number of iterations: ', num2str(i)]);
end

function new = compute_x(new, old, m, b)
    x = 0; 
    if length(new) == 3
        % iteration completed
        return;
    elseif length(new) == 2
        % we are on x3 equation
        x = (b(1,3) - m(3,1)*new(1) - m(3,2)*new(2))/m(3,3);
    elseif length(new) == 1
        % we are on x2 equation
        x = (b(1,2) - m(2,1)*new(1) - m(2,3)*old(3))/m(2,2);
    else
        % we are on x1 equation
        x = (b(1,1) - m(1,2)*old(2) - m(1,3)*old(3))/m(1,1);
    end

    
    new = [new, round(x, 4)];
    new = compute_x(new, old, m, b);

end

