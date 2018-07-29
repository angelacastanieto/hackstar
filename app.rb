# app.rb
require "sinatra"
require 'sinatra/activerecord'
require 'fillable-pdf'

class App < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/pdf" do
    pdf = FillablePDF.new 'final_form.pdf'
    path = params['path']


    File.delete('form.pdf') if File.exist?('form.pdf')
    codes = params['codes']

    transformed_codes = []

    codes.split(',').each do |code|
      transformed_codes << "'#{code}'"
    end

    conn = PG.connect( dbname: 'hh_proj' )

    counter = 1

    conn.exec("SELECT * from school_form_stats where num in (#{transformed_codes.join(',')})") do |result|
      p "SELECT * from school_form_stats where num in (#{transformed_codes.join(',')})"
      result.each_with_index do |row, i|
        field_name_1 = "untitled#{counter}"
        field_name_2 = "untitled#{counter+1}"
        field_name_3 = "untitled#{counter+2}"

        counter += 3

        name, grade, num = row.values_at('name', 'grade', 'num')

        pdf.set_field(field_name_1.to_sym, grade)
        pdf.set_field(field_name_2.to_sym, name)
        pdf.set_field(field_name_3.to_sym, num)
      end
    end

    pdf.save_as('form.pdf')

    headers "Content-Disposition" => "attachment", "Content-Type" => "application/pdf"

    send_file(File.open('form.pdf'), :disposition => 'attachment', :filename => 'form.pdf')
  end
end
