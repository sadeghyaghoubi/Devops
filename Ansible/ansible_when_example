# ansible_when_example
This repository contains examples of using the `when` condition in Ansible. The `when` condition allows you to apply conditions during the execution of a play. These conditions can be based on variable values, system facts, or other user-defined conditions.

## Table of Contents

- [Variable-based Conditions](#variable-based-conditions)
- [File or Directory Existence Conditions](#file-or-directory-existence-conditions)
- [Operating System-based Conditions](#operating-system-based-conditions)
- [Complex Conditions](#complex-conditions)


## Variable-based Conditions

You can define conditions based on variable values using comparison operators such as equal, not equal, greater than, less than, and more. For example:

```yaml
- name: Check variable value
  debug:
    msg: "The variable value is greater than 10"
  when: my_variable > 10
```

## File or Directory Existence Conditions
```yaml
You can define conditions based on the existence or non-existence of a file or directory. For example:
- name: Check if file exists
  debug:
    msg: "The file exists"
  when: ansible_facts['file_exists']
```

## Operating System-based Conditions
You can define conditions based on the target operating system. For example:
```yaml
- name: Perform task on Debian-based systems
  apt:
    name: package-name
  when: ansible_facts['distribution'] == 'Debian'
```

## Complex Conditions
You can define more complex conditions using logical operators such as and, or, and not. For example:
```yaml
- name: Perform task on CentOS 7 or Ubuntu 18.04
  debug:
    msg: "The task is executed on CentOS 7 or Ubuntu 18.04"
  when: (ansible_facts['distribution'] == 'CentOS' and ansible_facts['distribution_major_version'] == '7') or (ansible_facts['distribution'] == 'Ubuntu' and ansible_facts['distribution_version'] == '18.04')
```
