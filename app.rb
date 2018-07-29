# app.rb
require "sinatra"
require 'sinatra/activerecord'
require 'fillable-pdf'

class App < Sinatra::Base
  get "/" do
    File.delete('output.pdf') if File.exist?('output.pdf')

    # grade, zip
    pdf = FillablePDF.new 'school_form_edit.pdf'

    pdf.set_field(:untitled1, '')
    pdf.set_field(:untitled2, '2')
    pdf.set_field(:untitled3, '3')
    pdf.set_field(:untitled4, '4')
    pdf.set_field(:untitled5, '5')
    pdf.set_field(:untitled6, '6')
    pdf.set_field(:untitled7, '7')
    pdf.set_field(:untitled8, '8')
    pdf.set_field(:untitled9, '9')
    pdf.set_field(:untitled10, '10')
    pdf.set_field(:untitled11, '11')
    pdf.set_field(:untitled12, '12')
    pdf.set_field(:untitled13, '13')
    pdf.set_field(:untitled14, '14')
    pdf.set_field(:untitled15, '15')
    pdf.save_as('output.pdf')

    erb :index
  end

  get "/pdf" do
    File.delete('output.pdf') if File.exist?('output.pdf')

    # grade, zip
    pdf = FillablePDF.new 'school_form_edit.pdf'
    path = params['path']

    c1 = params['code1']
    c2 = params['code2']
    c3 = params['code3']
    c4 = params['code4']
    c5 = params['code5']

    s1 = params['school1']
    s2 = params['school2']
    s3 = params['school3']
    s4 = params['school4']
    s5 = params['school5']


    pdf.set_field(:untitled1, path)
    pdf.set_field(:untitled2, s1)
    pdf.set_field(:untitled3, c1)
    pdf.set_field(:untitled4, path)
    pdf.set_field(:untitled5, s2)
    pdf.set_field(:untitled6, c2)
    pdf.set_field(:untitled7, path)
    pdf.set_field(:untitled8, s3)
    pdf.set_field(:untitled9, c3)
    pdf.set_field(:untitled10, path)
    pdf.set_field(:untitled11, s4)
    pdf.set_field(:untitled12, c4)
    pdf.set_field(:untitled13, path)
    pdf.set_field(:untitled14, s5)
    pdf.set_field(:untitled15, c5)
    pdf.save_as('output.pdf')

    headers "Content-Disposition" => "attachment", "Content-Type" => "application/pdf"

    send_file(File.open('output.pdf'), :disposition => 'attachment', :filename => 'form.pdf')
  end
end
