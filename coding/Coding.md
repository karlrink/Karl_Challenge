

https://www.hackerrank.com/challenges/validating-credit-card-number/problem  

```
import re

def validator(cc):
    if not re.fullmatch(r'[456](\d{3})(-?\d{4}){3}', cc):
        return False
    cc = cc.replace('-', '')
    if re.search(r'(\d)\1{3,}', cc):
        return False
    return True
    
for i in range(int(input())):
    if validator(input()):
        print('Valid')
    else:
        print('Invalid')
        
```

