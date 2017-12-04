-- 创建微博数据库表 --
CREATE TABLE IF NOT EXISTS "T_status" (
    "statusId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "status" TEXT,
    PRIMARY KEY("statusId","userId")
);
