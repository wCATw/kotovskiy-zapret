import os
from collections import defaultdict
base_path = os.path.dirname(os.path.abspath(__file__))
input_file = os.path.join(base_path, 'list-auto.txt')
output_file = os.path.join(base_path, 'list.txt')
try:
    if not os.path.exists(output_file):
        with open(output_file, 'w') as f:
            pass
    if not os.path.exists(input_file):
        with open(input_file, 'w') as f:
            pass
    with open(output_file, 'r') as f:
        existing_domains = set(line.strip() for line in f if line.strip())
    with open(input_file, 'r') as f:
        domains = [line.strip() for line in f if line.strip()]
    domain_dict = defaultdict(list)
    for domain in domains:
        parts = domain.split('.')
        base_domain = '.'.join(parts[-2:]) if len(parts) >= 2 else domain
        domain_dict[base_domain].append(domain)
    unique_entries = existing_domains.copy()
    domains_to_remove = set()
    for base_domain, domain_list in domain_dict.items():
        if len(domain_list) > 1:
            unique_entries.add(base_domain)
            unique_entries.add(f"*.{base_domain}")
            domains_to_remove.update(domain_list)
    print("Записанные домены:")
    for entry in sorted(unique_entries-existing_domains):
        if not entry.startswith("*."):
            print(entry)
    with open(output_file, 'w') as f:
        for entry in sorted(unique_entries):
            f.write(entry + '\n')
    remaining_domains = [domain for domain in domains if domain not in domains_to_remove]
    with open(input_file, 'w') as f:
        for domain in remaining_domains:
            f.write(domain + '\n')
    print("Анализ списка доменов завершен. Изменения внесены.")
except Exception as e:
    print(f"Ошибка при анализе файлов: {e}")

input("Нажмите любую клавишу чтобы выйти..")
