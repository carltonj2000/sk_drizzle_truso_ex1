CREATE TABLE `choices` (
	`id` text PRIMARY KEY NOT NULL,
	`choice` text NOT NULL,
	`question_id` text NOT NULL,
	FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `questions` (
	`id` text PRIMARY KEY NOT NULL,
	`question` text NOT NULL,
	`delete_id` text NOT NULL,
	`expire_date` integer NOT NULL,
	`created_at` integer DEFAULT (cast (unixepoch() as int)) NOT NULL
);
--> statement-breakpoint
CREATE TABLE `votes` (
	`id` text PRIMARY KEY NOT NULL,
	`choice_id` text NOT NULL,
	`country` text DEFAULT 'unknown' NOT NULL,
	`voterId` text NOT NULL,
	`created_at` integer DEFAULT (cast (unixepoch() as int)) NOT NULL,
	FOREIGN KEY (`choice_id`) REFERENCES `choices`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `choices_choice_questionid_idx` ON `choices` (`choice`,`question_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `questions_question_idx` ON `questions` (`question`);--> statement-breakpoint
CREATE UNIQUE INDEX `questions_deleteid_idx` ON `questions` (`question`);--> statement-breakpoint
CREATE INDEX `votes_choice_idx` ON `votes` (`choice_id`);--> statement-breakpoint
CREATE INDEX `votes_country_idx` ON `votes` (`country`);--> statement-breakpoint
CREATE UNIQUE INDEX `voterid_choiceid_idx` ON `votes` (`voterId`,`choice_id`);