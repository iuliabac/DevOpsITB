<form method="POST" action="{{ isset($post) ? route('posts.update', $post) : route('posts.store') }}">
    @csrf
    @if(isset($post))
        @method('PUT')
    @endif
    <input type="text" name="title" value="{{ $post->title ?? '' }}" placeholder="Title">
    <textarea name="body">{{ $post->body ?? '' }}</textarea>
    <button type="submit">Save</button>
</form>
