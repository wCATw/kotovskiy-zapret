import os
from collections import defaultdict
base_path = os.path.dirname(os.path.abspath(__file__))
input_file = os.path.join(base_path, 'list-auto.txt')
try:
    if not os.path.exists(input_file):
        with open(input_file, 'w') as f:
            pass
    with open(input_file, 'r') as f:
        domains = [line.strip() for line in f if line.strip()]
    domain_dict = defaultdict(list)
    for domain in domains:
        parts = domain.split('.')
        base_domain = '.'.join(parts[-2:]) if len(parts) >= 2 else domain
        domain_dict[base_domain].append(domain)
    unique_entries = set(domains)
    domains_to_remove = set()
    for base_domain, domain_list in domain_dict.items():
        if len(domain_list) > 1:
            unique_entries.add(base_domain)
            unique_entries.add(f"*.{base_domain}")
            domains_to_remove.update(domain_list)
    remaining_domains = [d for d in unique_entries if not (d in domains_to_remove and not d.startswith('*'))]
    with open(input_file, 'w') as f:
        for entry in sorted(remaining_domains):
            f.write(entry + '\n')
    print("Domain list analysis complete. Updates saved to list-auto.txt.")
except Exception as e:
    print(f"Error processing file: {e}")
input("Press any key to exit...")
