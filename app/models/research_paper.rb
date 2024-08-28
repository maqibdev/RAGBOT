class ResearchPaper < ApplicationRecord
  has_many_attached :files

  validate :correct_document_mime_type
  validate :files_count_within_limit

  private

  def correct_document_mime_type
    if files.attached?
      files.each do |file|
        unless file.content_type.in?(%w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document text/plain text/markdown text/html application/x-latex application/vnd.oasis.opendocument.text])
          errors.add(:files, "Must be a valid document format (PDF, DOC/DOCX, LaTeX, ODT, TXT, Markdown, HTML)")
        end
      end
    else
      errors.add(:files, "must be attached")
    end
  end

  def files_count_within_limit
    if files.count > 50
      errors.add(:files, "Maximum number of files is 50")
    end
  end
end
