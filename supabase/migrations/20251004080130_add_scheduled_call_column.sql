/*
  # Add Scheduled Call Column to Leads

  ## Overview
  This migration adds the missing `scheduled_call` column to the leads table.

  ## Changes Made

  ### Add Column to Leads Table
    - `scheduled_call` (timestamptz, nullable) - Stores the date/time when a call is scheduled with the lead

  ## Notes
    - This column allows users to schedule calls with leads and track when they are due
    - The column is nullable since not all leads will have scheduled calls
*/

-- Add scheduled_call column to leads table if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name = 'leads'
      AND column_name = 'scheduled_call'
  ) THEN
    ALTER TABLE leads ADD COLUMN scheduled_call timestamptz DEFAULT NULL;
  END IF;
END $$;
