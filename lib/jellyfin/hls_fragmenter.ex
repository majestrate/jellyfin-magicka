defmodule HLSFragmenter do
  import FFmpex
  use FFmpex.Options

  defp ffmpeg(opts) when is_list(opts) do
    opts = Enum.join(option_y(), opts)

    FFmpex.new_command()
    |> add_global_option(opts)
  end

  defp ffmpeg(opts) do
    ffmpeg([opts])
  end

  def make_fragments(:source, in_file, out_playlist, out_template) do
    # ffmpeg -re -i $in_file -codec copy -map 0 -f segment -segment_list $out_playlist -segment_list_flags +live -segment_time 10 $out_template
    cmd =
      ffmpeg(option_re())
      |> add_input_file(in_file)
      |> add_file_option(option_c("copy"))
      |> add_file_option(option_map("0"))
      |> add_file_option(option_f("segment"))
      |> add_file_option("-segment_list #{out_playlist}")
      |> add_file_option("-segment_list_flags +live")
      |> add_file_option("-segment_time 10")
      |> add_output_file(out_template)

    :ok = execute(cmd)
  end
end
