function group_idx = get_sub_groups(sub_num,group_num)

group_per_sub1 = ceil(sub_num./group_num);
group_per_sub2 = group_per_sub1 - 1;

group_num2 = group_per_sub1*group_num - sub_num;
group_num1 = group_num - group_num2;

% group_idx1 = randperm(group_num,group_num1);
group_idx2 = 1:group_num2;
group_idx1 = setdiff(1:group_num,group_idx2);

age_group = zeros(group_num,1);
age_group(group_idx1) = group_per_sub1;
age_group(group_idx2) = group_per_sub2;

start_i = 1;
for i = 1:group_num
    end_i = start_i + age_group(i) - 1;
    group_idx{i,1} = start_i:end_i;
    start_i = end_i + 1;
end