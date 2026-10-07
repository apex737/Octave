# Octave + VS Code 환경 설정

> 목표: `.m` 파일에서 `Ctrl+Enter` 한 번으로 저장과 실행을 수행하고, 계산 결과는 VS Code 터미널에서, 그래프는 별도 Figure 창에서 확인한다.
>
> Windows / GNU Octave 11.3.0 기준. 아래 실행 파일 경로를 직접 설정한 뒤 정상 실행을 확인했다.

## 1. 준비 및 실행 파일 확인

- GNU Octave: https://octave.org/download
- VS Code: https://code.visualstudio.com/
- 실행 확장: **Octave Execution — LucasFA**

확인한 Octave 실행 파일:

```text
C:\Users\SSAFY\AppData\Local\Programs\GNU Octave\Octave-11.3.0\mingw64\bin\octave.exe
```

다른 PC에서는 사용자 이름, 버전, 설치 위치에 맞게 경로를 바꾼다.

바로가기 속성에 표시되는 다음 명령은 GUI 실행용이다. 환경 변수 Path에 그대로 넣지 않는다.

```text
"C:\Users\SSAFY\AppData\Local\Programs\GNU Octave\Octave-11.3.0\octave-launch.exe" --gui
```

## 2. Windows 사용자 Path 등록

1. `Win+R`을 누른다.
2. 다음 명령을 입력하고 Enter를 누른다.

```text
rundll32 sysdm.cpl,EditEnvironmentVariables
```

3. 위쪽 **SSAFY에 대한 사용자 변수 → Path → 편집 → 새로 만들기**로 이동한다.
4. 다음 폴더 경로를 추가한다.

```text
C:\Users\SSAFY\AppData\Local\Programs\GNU Octave\Octave-11.3.0\mingw64\bin
```

5. 열린 창을 모두 **확인**으로 닫는다.
6. VS Code 창을 전부 종료한 뒤 다시 실행한다.

주의 사항:

- Path에는 **폴더까지만** 넣는다. `octave.exe`, `--gui`, 따옴표를 넣지 않는다.
- 기존 Path 항목을 지우거나 덮어쓰지 않는다.
- 사용자 Path 수정은 일반적으로 관리자 권한이 필요 없다.
- Path 변경 후에는 새 터미널뿐 아니라 VS Code 자체를 완전히 다시 실행한다.

## 3. 터미널에서 연결 확인

VS Code에서 **터미널 → 새 터미널**을 연다. 사용하는 셸에 맞는 예시를 실행한다.

### PowerShell

```powershell
where.exe octave
octave --version
```

### Bash — Windows의 Git Bash 기준

```bash
command -v octave
octave --version
```

실행 파일 경로와 버전이 출력되면 터미널에서 Octave를 찾을 수 있는 상태다.

Path와 무관하게 실행 파일 자체를 확인하려면 다음 명령을 사용한다.

PowerShell:

```powershell
& "C:\Users\SSAFY\AppData\Local\Programs\GNU Octave\Octave-11.3.0\mingw64\bin\octave.exe" --version
```

Git Bash:

```bash
"/c/Users/SSAFY/AppData/Local/Programs/GNU Octave/Octave-11.3.0/mingw64/bin/octave.exe" --version
```

> Bash 예시는 Windows의 Git Bash용이다. WSL Ubuntu의 경로와 실행 환경은 별도이므로 이 문서에서는 Windows 로컬 VS Code 창을 사용한다.

## 4. Octave Execution 확장 설치

1. `Ctrl+Shift+X`로 확장 화면을 연다.
2. 아래 ID로 검색해서 설치한다.

```text
LucasFA.octaveexecution
```

- 이름: **Octave Execution**
- 제작자: **LucasFA**
- 설치 페이지: https://marketplace.visualstudio.com/items?itemName=LucasFA.octaveexecution

VS Code의 `code` 명령을 사용할 수 있다면 Git Bash에서 설치할 수도 있다.

```bash
code --install-extension LucasFA.octaveexecution
```

## 5. 실행 파일 경로 직접 지정 — 실제 해결에 필요했던 설정

이번 설정 과정에서는 Path 등록 안내 후에도 다음 오류가 발생했다.

```text
Octave path not found. Please set the path to Octave in the settings.
```

**확장 설정에 실행 파일의 전체 경로를 직접 지정한 뒤 정상 실행됐다.** 재설치보다 이 설정을 먼저 확인한다.

1. `Ctrl+Shift+P`를 누른다.
2. **Preferences: Open User Settings (JSON)**을 선택한다.
3. 아래 설정을 추가한다.

```json
{
  "octave.octaveLocation": "C:\\Users\\SSAFY\\AppData\\Local\\Programs\\GNU Octave\\Octave-11.3.0\\mingw64\\bin\\octave.exe",
  "octave.runInTerminal": true
}
```

기존 설정이 있다면 파일 전체를 덮어쓰지 않고, 기존 `{}` 내부에 두 항목만 추가하거나 수정한다. 항목 사이는 쉼표로 구분한다.

| 설정                    | 역할                                        |
| ----------------------- | ------------------------------------------- |
| `octave.octaveLocation` | Octave 실행 파일의 전체 경로를 직접 지정    |
| `octave.runInTerminal`  | 통합 터미널에서 실행하여 결과와 그래프 확인 |

**경로 입력 위치별 차이:**

| 입력 위치                       | 입력 내용                             |
| ------------------------------- | ------------------------------------- |
| Windows 환경 변수 Path          | `...\mingw64\bin` 폴더까지            |
| VS Code `octave.octaveLocation` | `...\mingw64\bin\octave.exe` 파일까지 |
| JSON 안의 Windows 경로          | 역슬래시를 `\\`로 작성                |

4. 저장한다.
5. `Ctrl+Shift+P` → **Developer: Reload Window**를 실행한다.

> `octave.octaveLocation`은 확장에서 사용할 실행 파일을 지정하는 설정이다. Path는 터미널에서 `octave`라는 짧은 명령을 사용하는 데 필요하다.

## 6. Ctrl+Enter로 저장 + 파일 전체 실행

확장의 기본 단축키는 다음과 같다.

| 기본 단축키        | 동작                        |
| ------------------ | --------------------------- |
| `Ctrl+Enter`       | 선택 영역 또는 현재 줄 실행 |
| `Ctrl+Shift+Enter` | 현재 파일 전체 실행         |

아래 설정으로 `.m` 파일의 `Ctrl+Enter`를 **저장 후 파일 전체 실행**으로 변경한다.

1. `Ctrl+Shift+P`를 누른다.
2. **Preferences: Open Keyboard Shortcuts (JSON)**을 선택한다. 기본값을 보는 Default 항목이 아니라 사용자 단축키 파일을 연다.
3. 아래 내용을 입력한다.

```json
[
  {
    "key": "ctrl+enter",
    "command": "runCommands",
    "args": {
      "commands": ["workbench.action.files.save", "octave.run"]
    },
    "when": "editorTextFocus && resourceExtname == .m"
  }
]
```

기존 단축키가 있다면 `[]` 내부에 객체만 추가한다. 기존 항목과 쉼표로 구분한다.

- `settings.json`: 실행 경로와 터미널 실행 방식 설정
- `keybindings.json`: 단축키 설정
- 단축키는 **코드 편집 영역에 커서가 있을 때** 적용된다.

## 7. 테스트 코드로 결과와 그래프 확인

VS Code에서 작업 폴더를 열고 `plot_test.m` 파일을 만든다. 처음에는 `C:\octave-work`처럼 영문 경로를 사용하면 경로 관련 문제를 줄일 수 있다.

```matlab
clc;
clear;
close all;

x = linspace(-5, 5, 500);
y = x.^2;

disp('Octave execution successful');
fprintf('Sampled minimum: %.6f\n', min(y));

figure(1);
plot(x, y, 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('y');
title('y = x^2');
drawnow;
```

파일을 저장한 뒤 코드 편집 영역에서 `Ctrl+Enter`를 누른다.
