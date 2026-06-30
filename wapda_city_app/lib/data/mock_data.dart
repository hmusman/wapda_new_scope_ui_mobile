import '../models/models.dart';

final List<Bill> mockBills = [
  Bill(id: 'b1', title: 'Service Charges', period: 'June 2026', amount: 8500, dueDate: '05 Jul 2026', paid: false),
  Bill(id: 'b2', title: 'Security Fund', period: 'June 2026', amount: 1500, dueDate: '05 Jul 2026', paid: false),
  Bill(id: 'b3', title: 'Service Charges', period: 'May 2026', amount: 8500, dueDate: '05 Jun 2026', paid: true, paidDate: '02 Jun 2026'),
  Bill(id: 'b4', title: 'Service Charges', period: 'April 2026', amount: 8200, dueDate: '05 May 2026', paid: true, paidDate: '03 May 2026'),
  Bill(id: 'b5', title: 'Annual Maintenance', period: '2025–26', amount: 12000, dueDate: '05 Apr 2026', paid: true, paidDate: '01 Apr 2026'),
];

final List<Complaint> mockComplaints = [
  Complaint(
    id: 'c1',
    title: 'Streetlight not working — Block C',
    category: 'Electrical',
    status: 'In Progress',
    date: '26 Jun 2026',
    description: 'The streetlight outside H-247 has been off for 4 nights. Block is dark after 9pm.',
    updates: ['Complaint received', 'Assigned to maintenance team', 'Technician visit scheduled — 01 Jul'],
  ),
  Complaint(
    id: 'c2',
    title: 'Water supply low pressure',
    category: 'Plumbing',
    status: 'Open',
    date: '24 Jun 2026',
    description: 'Low water pressure in the mornings for the past week across Block C.',
    updates: ['Complaint received'],
  ),
  Complaint(
    id: 'c3',
    title: 'Garbage not collected',
    category: 'Sanitation',
    status: 'Resolved',
    date: '18 Jun 2026',
    description: 'Garbage bins at the corner of Block C were not collected for 3 days.',
    updates: ['Complaint received', 'Assigned to sanitation team', 'Resolved — collection resumed'],
  ),
];

final List<NoticeItem> mockNotices = [
  NoticeItem(
    id: 'n1',
    title: 'Water supply suspension — 02 Jul',
    body: 'Water supply will be suspended from 9am–2pm on 02 Jul for tank cleaning across all blocks.',
    date: '29 Jun 2026',
    category: 'Maintenance',
    pinned: true,
  ),
  NoticeItem(
    id: 'n2',
    title: 'Annual society elections — nominations open',
    body: 'Nominations for the Management Committee elections are now open. Submit at the society office by 10 Jul.',
    date: '27 Jun 2026',
    category: 'Governance',
  ),
  NoticeItem(
    id: 'n3',
    title: 'New gate timing for visitors',
    body: 'Visitor gate entry will now close at 10pm instead of 11pm, effective 01 Jul.',
    date: '25 Jun 2026',
    category: 'Security',
  ),
];

final List<EventItem> mockEvents = [
  EventItem(
    id: 'e1',
    title: 'Independence Day Family Mela',
    date: '14 Aug 2026',
    time: '5:00 PM',
    location: 'Central Park',
    description: 'Join us for games, food stalls, and a flag-hoisting ceremony with the whole society.',
    coverColor: 'primary',
    going: 184,
  ),
  EventItem(
    id: 'e2',
    title: 'Free Health Checkup Camp',
    date: '06 Jul 2026',
    time: '10:00 AM',
    location: 'Community Hall',
    description: 'Free BP, sugar, and BMI checks by Faisalabad General Hospital staff.',
    coverColor: 'success',
    going: 62,
  ),
  EventItem(
    id: 'e3',
    title: 'Monthly MC Open Session',
    date: '03 Jul 2026',
    time: '7:00 PM',
    location: 'Society Office',
    description: 'Residents can raise questions directly with the Management Committee.',
    coverColor: 'amber',
    going: 41,
  ),
];

final List<DirectoryEntry> mockDirectoryLocal = [
  DirectoryEntry(id: 'd1', name: 'Ahsan Raza', subtitle: 'Owner · H-247, Block C', phone: '+92 300 1234567', initials: 'AR'),
  DirectoryEntry(id: 'd2', name: 'Sana Tariq', subtitle: 'Owner · H-118, Block A', phone: '+92 301 9876543', initials: 'ST'),
  DirectoryEntry(id: 'd3', name: 'Imran Sheikh', subtitle: 'Owner · H-302, Block D', phone: '+92 333 4455667', initials: 'IS'),
  DirectoryEntry(id: 'd4', name: 'Farah Khan', subtitle: 'Tenant · H-090, Block B', phone: '+92 321 7766554', initials: 'FK'),
];

final List<ServiceProvider> mockServiceProviders = [
  ServiceProvider(
    id: 'sp1',
    name: 'Iqbal Electricians',
    category: 'Electrician',
    rating: 4.6,
    phone: '+92 302 1112233',
    initials: 'IE',
    description: 'Society-approved electrician — wiring, fans, fittings.',
  ),
  ServiceProvider(
    id: 'sp2',
    name: 'Khan Plumbing Services',
    category: 'Plumber',
    rating: 4.4,
    phone: '+92 311 2223344',
    initials: 'KP',
    description: 'Pipe leaks, geysers, bathroom fittings.',
  ),
  ServiceProvider(
    id: 'sp3',
    name: 'CleanHome Maids',
    category: 'House Help',
    rating: 4.8,
    phone: '+92 345 3334455',
    initials: 'CM',
    description: 'Verified domestic staff, background-checked by WC office.',
  ),
];

final List<Visitor> mockVisitors = [
  Visitor(id: 'v1', name: 'Zara Malik', purpose: 'Guest', time: 'Today, 4:30 PM', status: 'Expected'),
  Visitor(id: 'v2', name: 'TCS Courier', purpose: 'Delivery', time: 'Today, 1:15 PM', status: 'Checked In'),
  Visitor(id: 'v3', name: 'Usman Ali', purpose: 'Guest', time: 'Yesterday, 7:00 PM', status: 'Checked Out'),
];

final List<Post> mockPosts = [
  Post(
    id: 'p1',
    author: 'Sana Tariq',
    initials: 'ST',
    time: '2h ago',
    body: 'Lost a grey tabby cat near Block A park. Answers to "Mishti". Please contact if seen!',
    category: 'Lost & Found',
    likes: 12,
    comments: 4,
  ),
  Post(
    id: 'p2',
    author: 'Imran Sheikh',
    initials: 'IS',
    time: '5h ago',
    body: 'Reminder: society badminton tournament signups close this Friday. DM me to register your team.',
    category: 'Event',
    likes: 28,
    comments: 9,
  ),
  Post(
    id: 'p3',
    author: 'Farah Khan',
    initials: 'FK',
    time: '1d ago',
    body: 'Heads up — water tanker on Main Boulevard is leaking, reported to WC office already.',
    category: 'Alert',
    likes: 19,
    comments: 3,
  ),
];

final List<Listing> mockListings = [
  Listing(
    id: 'l1',
    title: 'Dining Table (6-seater, wood)',
    price: 'Rs 35,000',
    category: 'Furniture',
    seller: 'Ahsan Raza',
    time: '3h ago',
    description: 'Solid sheesham wood dining table, lightly used, 6 chairs included.',
  ),
  Listing(
    id: 'l2',
    title: 'iPhone 13, 128GB',
    price: 'Rs 145,000',
    category: 'Electronics',
    seller: 'Bilal Ahmed',
    time: '1d ago',
    description: 'Excellent condition, box and charger included, battery health 91%.',
  ),
  Listing(
    id: 'l3',
    title: 'Kids Bicycle (16-inch)',
    price: 'Rs 8,500',
    category: 'Other',
    seller: 'Sana Tariq',
    time: '2d ago',
    status: 'Sold',
    description: 'Barely used, great for ages 5–8.',
  ),
];

final List<Poll> mockPolls = [
  Poll(
    id: 'pl1',
    question: 'Should the society install solar street lights on Main Boulevard?',
    options: ['Yes, fully solar', 'Partial / hybrid', 'No, keep current'],
    votes: [212, 84, 31],
    votedByMe: true,
  ),
  Poll(
    id: 'pl2',
    question: 'Preferred timing for the new community gym?',
    options: ['6 AM – 10 PM', '24/7 access', '6 AM – 12 AM'],
    votes: [98, 145, 60],
  ),
  Poll(
    id: 'pl3',
    question: 'Annual sports gala — which month works best?',
    options: ['September', 'November', 'February'],
    votes: [140, 96, 77],
    closed: true,
  ),
];

final List<AppNotification> mockNotifications = [
  AppNotification(id: 'no1', title: 'Bill due in 5 days', body: 'June service charges of Rs 8,500 are due 05 Jul.', time: '1h ago', type: 'bill'),
  AppNotification(id: 'no2', title: 'Complaint update', body: 'Your streetlight complaint is now In Progress.', time: '3h ago', type: 'complaint'),
  AppNotification(id: 'no3', title: 'New notice posted', body: 'Water supply suspension on 02 Jul.', time: '1d ago', type: 'notice', read: true),
  AppNotification(id: 'no4', title: 'Visitor checked in', body: 'TCS Courier checked in at the main gate.', time: '1d ago', type: 'visitor', read: true),
];

final List<ChatThread> mockChats = [
  ChatThread(
    id: 'ch1',
    withName: 'Iqbal Electricians',
    initials: 'IE',
    messages: [
      ChatMessage(text: 'Assalam o Alaikum, I need an electrician for fan installation.', fromMe: true, time: '10:02 AM'),
      ChatMessage(text: 'Walaikum Assalam! Sure, what time works for you tomorrow?', fromMe: false, time: '10:05 AM'),
      ChatMessage(text: 'Around 11 AM would be great.', fromMe: true, time: '10:06 AM'),
      ChatMessage(text: 'Confirmed, see you at 11 AM.', fromMe: false, time: '10:07 AM'),
    ],
  ),
];
