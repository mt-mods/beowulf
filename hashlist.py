import subprocess
import os

luanti_repo_url = "https://github.com/luanti-org/luanti.git"

# List of cheat client repos
cheat_client_urls = [
    "https://github.com/dragonfireclient/dragonfireclient",
    "https://github.com/Teeranu/TeranClient",
    "https://github.com/BotBoyM1/TeranClientCustomized",
    "https://github.com/VoidCosmo/waspsaliva",
    "https://github.com/otterminetest/OtterClient",
    "https://github.com/TeamAcedia/CloakV4",
    "https://github.com/IonicCheese/erbium",
]

tmp = "./tmp"
if not os.path.exists(tmp):
	os.makedirs(tmp)

# Fetch all commits from Luanti repo
luanti_repo_path = os.path.join(tmp, "luanti")
subprocess.run(f"git clone {luanti_repo_url} {luanti_repo_path}", shell=True)
subprocess.run(f"git -C {luanti_repo_path} fetch --all", shell=True)

luanti_commits = subprocess.check_output(f"git -C {luanti_repo_path} log --format=%H", shell=True).decode("utf-8").splitlines()

for url in cheat_client_urls:
    # Extract repo name from URL
    repo_name = url.split("/")[-1]#.replace(".git", "")

    path = os.path.join(tmp, repo_name)
    subprocess.run(f"git clone {url} {path}", shell=True)
    subprocess.run(f"git -C {path} fetch --all", shell=True)

    commits = subprocess.check_output(f"git -C {path} log --format=%H", shell=True).decode("utf-8").splitlines()

    # Find commits which are in cheat client but not Luanti
    unique_commits = [commit for commit in commits if commit not in luanti_commits]

    # Write new commits to file
    output_file = os.path.join("hashes", repo_name) + ".txt"
    existing_commits = set()
    if os.path.exists(output_file):
        with open(output_file, "r") as file:
            existing_commits = set(line.strip() for line in file.readlines())

    new_commits = []
    for commit in unique_commits:
        oneline_commit = subprocess.check_output(f"git -C {path} log -1 --oneline {commit}", shell=True).decode("utf-8").strip()
        if oneline_commit not in existing_commits:
            new_commits.append(oneline_commit)

    if new_commits:
        with open(output_file, "a") as file:  # Append to *add* commits
            for commit in new_commits:
                file.write(f"{commit}\n")

        print(f"Added commits for {repo_name}")
