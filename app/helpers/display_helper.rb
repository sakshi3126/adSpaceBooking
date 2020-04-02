module DisplayHelper
  def upcase(string)
    string.upcase
  end

  def format_class(klass)
    klass.class.name
  end

  def format_succinct_date(date)
    if date.present?
      # date.strftime("%e %b, %Y %H:%M")
      date.strftime('%d-%b-%y')
    else
      '-'
    end
  end

  def format_date(date)
    if date.present?
      # date.strftime("%e %b, %Y %H:%M")
      date.strftime('%d-%b-%Y')
    else
      '-'
    end
  end

  def format_date_with_time(date)
    if date.present?
      # date.strftime("%e %b, %Y %H:%M")
      date.strftime('%d-%b-%Y %H:%M')
    else
      '-'
    end
  end


  def format_date_time_meridiem(date)
    if date.present?
      date.strftime('%d-%b-%Y, %I:%M %p')
    else
      '-'
    end
  end

  def format_date_time_with_second(date)
    if date.present?
      date.strftime('%d-%b-%Y, %I:%M:%S %p')
    else
      '-'
    end
  end

  def format_date_without_time(date)
    if date.present?
      date.strftime('%d-%b-%Y')
    end
  end

  def format_date_without_time_and_date(date)
    if date.present?
      date.strftime('%b-%Y')
    end
  end


  def format_times_ago(time)
    [time_ago_in_words(time), 'ago'].join(' ').html_safe
  end



end
