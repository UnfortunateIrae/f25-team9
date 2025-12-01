const API_BASE = (location.protocol === 'file:') ? 'http://localhost:8080/api' : '/api';

async function fetchJSON(url) {
  const res = await fetch(url);
  if (!res.ok) {
    const txt = await res.text();
    throw new Error(`Fetch ${url} failed: ${res.status} ${res.statusText} - ${txt}`);
  }
  return res.json();
}

let currentTopics = [];
let currentArticles = [];
let activeTopicId = null;

function getSubscriptions() { try { return JSON.parse(localStorage.getItem('subscriptions') || '[]'); } catch { return []; } }
function saveSubscriptions(arr) { localStorage.setItem('subscriptions', JSON.stringify(arr)); }
function isSubscribed(topicId) { return getSubscriptions().includes(topicId); }
function toggleSubscription(topicId) { const subs = getSubscriptions(); const idx = subs.indexOf(topicId); if (idx === -1) subs.push(topicId); else subs.splice(idx,1); saveSubscriptions(subs); renderTopics(currentTopics); }

async function loadTopicsAndArticles() {
  try { currentTopics = await fetchJSON(`${API_BASE}/topics`); } catch (e) { console.error('Failed to load topics', e); currentTopics = []; }
  try { currentArticles = await fetchJSON(`${API_BASE}/articles`); } catch (e) { console.error('Failed to load articles', e); currentArticles = []; }

  const topicMap = new Map((currentTopics||[]).map(t => [t.id ?? t.topicId ?? t._id, t]));
  currentArticles = (currentArticles||[]).map(a => { const tid = a.topicId ?? (a.topic && (a.topic.id ?? a.topicId)) ?? null; const t = tid ? topicMap.get(tid) : (a.topic || null); return { ...a, topicId: tid, topicName: t ? (t.name||t.title) : (a.topicName||'') }; });

  renderTopics(currentTopics);
  renderArticles(currentArticles);
}

async function fetchAllArticles() { try { currentArticles = await fetchJSON(`${API_BASE}/articles`); } catch (e) { console.error('Failed to load articles', e); currentArticles = []; } renderArticles(currentArticles); }

async function loadArticlesForTopic(topicId) { try { const articles = await fetchJSON(`${API_BASE}/articles/topic/${encodeURIComponent(topicId)}`); currentArticles = Array.isArray(articles) ? articles : []; } catch (e) { console.error('Failed to load articles for topic', topicId, e); currentArticles = []; } renderArticles(currentArticles); }

async function loadArticlesForTopicByName(topicName) {
  if (!topicName) return;
  if (!currentTopics || !currentTopics.length) {
    try { currentTopics = await fetchJSON(`${API_BASE}/topics`); } catch (e) { console.error('Failed to load topics for lookup', e); currentTopics = []; }
  }
  const found = (currentTopics||[]).find(t => (t.name || t.title || '').toLowerCase() === String(topicName).toLowerCase());
  if (found) {
    const id = found.id ?? found.topicId ?? found._id;
    activeTopicId = id;
    return loadArticlesForTopic(id);
  }
  filterArticlesByKeyword(topicName);
}

function renderTopics(topics) {
  const container = document.getElementById('topic-filters'); if (!container) return; container.innerHTML = '';
  const allBtn = document.createElement('button'); allBtn.className = 'filter-btn'; allBtn.textContent = 'All'; allBtn.onclick = () => { activeTopicId = null; fetchAllArticles(); renderTopics(currentTopics); }; container.appendChild(allBtn);

  (topics||[]).forEach(t => {
    const id = t.id ?? t.topicId ?? t._id;
    const btn = document.createElement('button');
    btn.className = 'filter-btn topic-btn';
    btn.dataset.topicId = id;
    btn.textContent = t.name || t.title || `Topic ${id}`;
    if (String(activeTopicId) === String(id)) btn.classList.add('active');
    btn.onclick = () => { activeTopicId = id; loadArticlesForTopic(id); renderTopics(currentTopics); };

    const subToggle = document.createElement('span'); subToggle.textContent = isSubscribed(id) ? ' ●' : ' ○'; subToggle.style.cursor = 'pointer'; subToggle.title = isSubscribed(id) ? 'Unsubscribe' : 'Subscribe'; subToggle.onclick = (ev) => { ev.stopPropagation(); toggleSubscription(id); };
    btn.appendChild(subToggle);
    container.appendChild(btn);
  });

  const grid = document.getElementById('topicsGrid');
  if (grid) {
    grid.innerHTML = '';
    (topics||[]).forEach(t => {
      const id = t.id ?? t.topicId ?? t._id;
      const card = document.createElement('div');
      card.className = 'topic-card';

      const h3 = document.createElement('h3');
      h3.textContent = t.name || t.title || `Topic ${id}`;
      card.appendChild(h3);

      const p = document.createElement('p');
      p.textContent = t.description || t.summary || '';
      card.appendChild(p);

      const controls = document.createElement('div');
      controls.style.display = 'flex';
      controls.style.gap = '10px';

      const viewBtn = document.createElement('button');
      viewBtn.className = 'btn';
      viewBtn.textContent = 'View articles';
      viewBtn.onclick = () => { activeTopicId = id; loadArticlesForTopic(id); window.location.href = 'index.html'; };
      controls.appendChild(viewBtn);

      const subBtn = document.createElement('button');
      subBtn.className = 'btn';
      subBtn.textContent = isSubscribed(id) ? 'Unsubscribe' : 'Subscribe';
      subBtn.onclick = () => { toggleSubscription(id); subBtn.textContent = isSubscribed(id) ? 'Unsubscribe' : 'Subscribe'; };
      controls.appendChild(subBtn);

      card.appendChild(controls);
      grid.appendChild(card);
    });
  }
}

function renderArticles(articles) {
  const list = document.getElementById('articles-list'); if (!list) return; list.innerHTML = '';
  const items = (articles||[]); if (!items.length) { list.innerHTML = '<p>No articles found.</p>'; return; }

  items.forEach(a => {
    const el = document.createElement('article'); el.className = 'article-card';
    const header = document.createElement('div'); header.className = 'article-header'; const topicBadge = document.createElement('div'); topicBadge.className = 'article-topic'; topicBadge.textContent = a.topicName || ''; header.appendChild(topicBadge);
    const h3 = document.createElement('h3'); h3.textContent = a.title || a.headline || 'Untitled'; header.appendChild(h3); el.appendChild(header);
    const body = document.createElement('div'); body.className = 'article-body'; const p = document.createElement('p'); p.textContent = a.summary || a.excerpt || (a.content ? a.content.substring(0,200) + '...' : ''); body.appendChild(p); el.appendChild(body);
    const footer = document.createElement('div'); footer.className = 'article-footer'; const author = document.createElement('div'); author.className = 'article-author'; author.innerHTML = `<strong>${escapeHtml((a.writer && a.writer.name) || a.author || 'Unknown')}</strong>`; footer.appendChild(author);
    const readBtn = document.createElement('button'); readBtn.className = 'read-more-btn'; readBtn.textContent = 'Read more'; readBtn.onclick = () => openArticleModal(a); footer.appendChild(readBtn); el.appendChild(footer);
    list.appendChild(el);
  });
}

function openArticleModal(article) { const content = article.content || article.summary || 'No content'; const w = window.open('', '_blank', 'width=800,height=600'); w.document.write(`<h1>${escapeHtml(article.title||'Article')}</h1><div>${escapeHtml(content)}</div>`); }

function filterArticlesByKeyword(keyword) { if (!keyword) return renderArticles(currentArticles); const kw = String(keyword).toLowerCase(); const filtered = (currentArticles||[]).filter(a => (a.title||'').toLowerCase().includes(kw)); if (filtered.length) renderArticles(filtered); else fetchAllArticles().then(() => renderArticles((currentArticles||[]).filter(a => (a.title||'').toLowerCase().includes(kw)))).catch(err => { console.error(err); renderArticles([]); }); }

document.addEventListener('DOMContentLoaded', () => { loadTopicsAndArticles(); const refreshBtn = document.getElementById('refresh-btn'); if (refreshBtn) refreshBtn.onclick = () => loadTopicsAndArticles(); });

function escapeHtml(str) { if (!str) return ''; return String(str).replace(/[&<>"']/g, s => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[s])); }

