from subprocess import Popen, PIPE, STDOUT
import re
import subprocess

REGEX = re.compile(r"(:(?:[fFoO][^:]*:)*)")
NORMAL = "ws-normal"
FOCUSED = "ws-focused"
OCCUPIED = "ws-occupied"

res = Popen(["bspc", "subscribe", "report"], stdout=PIPE, stderr=STDOUT)
state: list[str] = [NORMAL] * 9
if res.stdout is None:
    exit(1)
try:
    with res.stdout as lines:
        for line in lines:
            cmd_args = "eww -c $EWW_ROOT update"
            status = line.decode(encoding="ascii").strip()
            result = REGEX.search(status)
            if result is None:
                continue
            desktops = result.group(0)[1:-1].split(sep=":")
            cnt = 0
            for d in desktops:
                mode = d[0]
                name = int(d[1])
                s = NORMAL
                if mode == "O" or mode == "F":
                    s = FOCUSED
                elif mode == "o":
                    s = OCCUPIED
                if state[name - 1] != s:
                    state[name - 1] = s
                    cmd_args += f" ws{name}={s}"
                    cnt += 1
            if cnt != 0:
                subprocess.run(cmd_args, shell=True)

except KeyboardInterrupt:
    exit(0)
