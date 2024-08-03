@echo off

:: ��鵱ǰĿ¼�Ƿ���һ��Git�ֿ�
if not exist ".git" (
    echo ��ǰĿ¼����һ��Git�ֿ⡣���ڳ�ʼ���µ�Git�ֿ�...
    git init
    
    :: ��ʾ�û�����Զ�ֿ̲�URL
    set /p remote_url=������Զ�ֿ̲��URL��
    git remote add origin "%remote_url%"
) else (
    :: ��ʾ��ǰ��Զ�ֿ̲�URL
    echo ��ǰ���õ�Զ�ֿ̲�URL�ǣ�
    git remote -v

    :: ��ʾ��ǰ��֧
    echo ��ǰ���ڵķ�֧�ǣ�
    git branch
)

:: ��ȡ���µ�Զ�ֿ̲����
git pull origin main --allow-unrelated-histories

:: ������и��ĵ��ݴ���
git add .\*

:: ��ʾ�û������ύ��Ϣ
set /p commit_message=�������ύ������

:: �ύ���ģ�ʹ���û�������ύ��Ϣ
git commit -m "%commit_message%"

:: ���͸��ĵ�Զ�ֿ̲�
git push origin main

echo �����ѳɹ���ʼ���������Ҫ������ȡ���ύ�����͵�Զ�ֿ̲�
pause
