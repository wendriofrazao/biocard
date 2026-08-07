-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('STUDENT', 'PROFESSOR');

-- CreateEnum
CREATE TYPE "ClipboardType" AS ENUM ('FLASHCARD', 'DOCUMENT', 'CLINICAL_CASE');

-- CreateEnum
CREATE TYPE "ClipboardStatus" AS ENUM ('STUDYING', 'REVIEW', 'COMPLETED');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "avatar" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cabinet" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "color" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Cabinet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Drawer" (
    "id" TEXT NOT NULL,
    "cabinetId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "icon" TEXT,
    "color" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Drawer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Folder" (
    "id" TEXT NOT NULL,
    "drawerId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "coverImage" TEXT,
    "icon" TEXT,
    "color" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Folder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clipboard" (
    "id" TEXT NOT NULL,
    "folderId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT,
    "type" "ClipboardType" NOT NULL,
    "categoryId" TEXT,
    "difficulty" INTEGER NOT NULL DEFAULT 1,
    "status" "ClipboardStatus" NOT NULL DEFAULT 'STUDYING',
    "icon" TEXT,
    "color" TEXT,
    "estimatedTime" INTEGER,
    "favorite" BOOLEAN NOT NULL DEFAULT false,
    "content" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Clipboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "color" TEXT,
    "icon" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "color" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClipboardTag" (
    "clipboardId" TEXT NOT NULL,
    "tagId" TEXT NOT NULL,

    CONSTRAINT "ClipboardTag_pkey" PRIMARY KEY ("clipboardId","tagId")
);

-- CreateTable
CREATE TABLE "Attachment" (
    "id" TEXT NOT NULL,
    "clipboardId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "extension" TEXT,
    "size" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Attachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudyHistory" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "clipboardId" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL,
    "finishedAt" TIMESTAMP(3),
    "duration" INTEGER,
    "score" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StudyHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" TEXT NOT NULL,
    "clipboardId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "lastReview" TIMESTAMP(3),
    "nextReview" TIMESTAMP(3),
    "easeFactor" DOUBLE PRECISION NOT NULL DEFAULT 2.5,
    "interval" INTEGER NOT NULL DEFAULT 0,
    "repetitions" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorite" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "clipboardId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Favorite_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "Cabinet_userId_idx" ON "Cabinet"("userId");

-- CreateIndex
CREATE INDEX "Drawer_cabinetId_idx" ON "Drawer"("cabinetId");

-- CreateIndex
CREATE INDEX "Folder_drawerId_idx" ON "Folder"("drawerId");

-- CreateIndex
CREATE INDEX "Clipboard_folderId_idx" ON "Clipboard"("folderId");

-- CreateIndex
CREATE INDEX "Clipboard_authorId_idx" ON "Clipboard"("authorId");

-- CreateIndex
CREATE INDEX "Clipboard_categoryId_idx" ON "Clipboard"("categoryId");

-- CreateIndex
CREATE INDEX "Clipboard_type_idx" ON "Clipboard"("type");

-- CreateIndex
CREATE INDEX "Clipboard_status_idx" ON "Clipboard"("status");

-- CreateIndex
CREATE INDEX "Category_userId_idx" ON "Category"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Category_userId_name_key" ON "Category"("userId", "name");

-- CreateIndex
CREATE INDEX "Tag_userId_idx" ON "Tag"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_userId_name_key" ON "Tag"("userId", "name");

-- CreateIndex
CREATE INDEX "ClipboardTag_tagId_idx" ON "ClipboardTag"("tagId");

-- CreateIndex
CREATE INDEX "Attachment_clipboardId_idx" ON "Attachment"("clipboardId");

-- CreateIndex
CREATE INDEX "StudyHistory_userId_idx" ON "StudyHistory"("userId");

-- CreateIndex
CREATE INDEX "StudyHistory_clipboardId_idx" ON "StudyHistory"("clipboardId");

-- CreateIndex
CREATE INDEX "StudyHistory_startedAt_idx" ON "StudyHistory"("startedAt");

-- CreateIndex
CREATE INDEX "Review_nextReview_idx" ON "Review"("nextReview");

-- CreateIndex
CREATE UNIQUE INDEX "Review_userId_clipboardId_key" ON "Review"("userId", "clipboardId");

-- CreateIndex
CREATE INDEX "Favorite_clipboardId_idx" ON "Favorite"("clipboardId");

-- CreateIndex
CREATE UNIQUE INDEX "Favorite_userId_clipboardId_key" ON "Favorite"("userId", "clipboardId");

-- AddForeignKey
ALTER TABLE "Cabinet" ADD CONSTRAINT "Cabinet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Drawer" ADD CONSTRAINT "Drawer_cabinetId_fkey" FOREIGN KEY ("cabinetId") REFERENCES "Cabinet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Folder" ADD CONSTRAINT "Folder_drawerId_fkey" FOREIGN KEY ("drawerId") REFERENCES "Drawer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clipboard" ADD CONSTRAINT "Clipboard_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "Folder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clipboard" ADD CONSTRAINT "Clipboard_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clipboard" ADD CONSTRAINT "Clipboard_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tag" ADD CONSTRAINT "Tag_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClipboardTag" ADD CONSTRAINT "ClipboardTag_clipboardId_fkey" FOREIGN KEY ("clipboardId") REFERENCES "Clipboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClipboardTag" ADD CONSTRAINT "ClipboardTag_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "Tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attachment" ADD CONSTRAINT "Attachment_clipboardId_fkey" FOREIGN KEY ("clipboardId") REFERENCES "Clipboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudyHistory" ADD CONSTRAINT "StudyHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudyHistory" ADD CONSTRAINT "StudyHistory_clipboardId_fkey" FOREIGN KEY ("clipboardId") REFERENCES "Clipboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_clipboardId_fkey" FOREIGN KEY ("clipboardId") REFERENCES "Clipboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_clipboardId_fkey" FOREIGN KEY ("clipboardId") REFERENCES "Clipboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;
