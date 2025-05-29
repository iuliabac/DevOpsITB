<a href="{{ route('posts.create') }}">New Post</a>
@foreach ($posts as $post)
    <h2>{{ $post->title }}</h2>
    <p>{{ $post->body }}</p>
    <a href="{{ route('posts.edit', $post) }}">Edit</a>
    <form method="POST" action="{{ route('posts.destroy', $post) }}">
        @csrf @method('DELETE')
        <button type="submit">Delete</button>
    </form>
@endforeach
