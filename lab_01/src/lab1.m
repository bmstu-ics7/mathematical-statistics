function lab1()
    X = [
        -7.50, -6.61, -7.85, -7.72, -8.96, -6.55, -7.82, -6.55, -6.87, -5.95, ...
        -5.05, -4.56, -6.14, -6.83, -6.33, -7.67, -4.65, -6.30, -8.01, -5.88, ...
        -5.38, -7.06, -6.85, -5.53, -7.83, -5.89, -7.57, -6.76, -6.02, -4.62, ...
        -8.55, -6.37, -7.52, -5.78, -6.12, -8.82, -5.14, -7.68, -6.14, -6.48, ...
        -7.14, -6.25, -7.32, -5.51, -6.97, -7.86, -7.04, -6.24, -6.41, -6.00, ...
        -7.46, -6.00, -6.06, -5.94, -5.39, -5.06, -6.91, -8.06, -7.24, -6.42, ...
        -8.73, -6.20, -7.35, -5.90, -5.02, -5.93, -7.56, -7.49, -6.26, -6.06, ...
        -7.35, -5.10, -6.52, -7.97, -5.71, -7.62, -7.33, -5.31, -6.21, -7.28, ...
        -7.99, -4.65, -7.07, -7.31, -7.72, -5.22, -7.00, -7.17, -6.64, -7.00, ...
        -6.12, -6.57, -6.07, -6.65, -7.60, -6.92, -6.78, -6.85, -7.90, -7.40, ...
        -5.32, -6.58, -6.71, -5.07, -5.80, -4.87, -5.90, -7.43, -7.03, -6.67, ...
        -7.72, -5.83, -7.49, -6.68, -6.71, -7.31, -7.83, -7.92, -5.97, -6.34, ...
    ];

    Params(X);
    Intervals(X);
    MakeGraphs(X);
end

% ������� ���������� ������� � ������ �� �� �����
% [in] X - ����������� ������������
function Params(X)
    % ������������ �������� �������
    maxX = max(X);
    fprintf("Mmax = %.3f\n", maxX);

    % ����������� �������� �������
    minX = min(X);
    fprintf("Mmin = %.3f\n", minX);

    % ������� �������
    R = maxX - minX;
    fprintf("R    = %.3f\n", R);

    % ������ ��������������� �������� �������
    M = mean(X);
    fprintf("M    = %.3f\n", M);

    % ������ ��������� �������
    D = FindD(X);
    fprintf("D    = %.3f\n", D);
end

% ������� ��� ���������� ������ ��������� �������
% [in] X - ����������� ������������
% [return] ������ ��������� �������
function D = FindD(X)
    D = sum((X - mean(X)) .^ 2) / (length(X) - 1);
    return
end

% ������� ��� ����������� �������� � m ����������
% � ������ �� ����� ���������� ��������� � ������ ���������
% (m = [log2(n)] + 2)
% [in] X - ����������� ������������
function Intervals(X)
    m = floor(log2(length(X))) + 2;
    delta = (max(X) - min(X)) / m;
    borders = min(X) : delta : max(X);

    fprintf('\n%d intervals:\n', m);
    for i = 1:(length(borders) - 1)
        count = 0;
        for x = X
            % ��������� ������� �������� � ���� ������ ��������
            if (i == length(borders) - 1) && (x >= borders(i)) && (x <= borders(i + 1))
                count = count + 1;
            % ��������� ��������� ������������ ������ �����
            elseif (x >= borders(i)) && (x < borders(i + 1))
                count = count + 1;
            end
        end

        printableString = '[%.3f; %.3f) -> %d\n';
        if (i == length(borders) - 1)
            printableString = '[%.3f; %.3f] -> %d\n';
        end

        fprintf(printableString, borders(i), borders(i + 1), count);
    end
end

% ������� ��� ��������� ��������
% [in] X - ����������� ������������
function MakeGraphs(X)
    x = sort(X);

    subplot(2, 1, 1);
    % �����������
    histogram(X, 'Normalization', 'pdf');
    hold on;
    % ������ ������� ��������� ������������� ���������� ��������� ��������
    f = normpdf(x, mean(x), sqrt(FindD(x)));
    p1 = plot(x, f);
    p1.LineWidth = 2;
    hold off;
    legend({'�����������', '������� ��������� �������������'}, ...
        'Location','northwest');

    subplot(2, 1, 2);
    % ������������ ������� �������������
    histogram(X, 'Normalization', 'cdf');
    hold on;
    % ������� ������������� ���������� ��������� ��������
    f = normcdf(x, mean(x), sqrt(FindD(x)));
    p2 = plot(x, f);
    p2.LineWidth = 2;
    hold off;
    legend({'������������ ������� �������������', '������� �������������'}, ...
        'Location','northwest');
end