/* sched__init_default_alloc_table @ 0x8ca388, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__start
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__init_default_alloc_table
sched__init_default_alloc_table:
	.global L_8ca388
L_8ca388:
	push_s blink
L_8ca38a:
	push_s r13
L_8ca38c:
	mov_s r13,0x847a3c
L_8ca392:
	mov_s r0,r13
L_8ca394:
	bl.d L_8c1cd8
L_8ca398:
	mov_s r1,0xc
L_8ca39a:
	st 0xafc8,[r13, 0x14]
L_8ca3a2:
	mov_s r0,0x8b
L_8ca3a4:
	stw_s r0,[r13,0xe]
L_8ca3a6:
	mov_s r2,0x1
L_8ca3a8:
	stb_s r2,[r13,0xd]
L_8ca3aa:
	stw 0xbb8,[r13, 0x10]
L_8ca3b2:
	mov_s r1,0xf
L_8ca3b4:
	stb_s r1,[r13,0xc]
L_8ca3b6:
	st 0x10d88,[r13, 0x20]
L_8ca3be:
	mov r0,0x203
L_8ca3c2:
	stw_s r0,[r13,0x1a]
L_8ca3c4:
	stb_s r2,[r13,0x19]
L_8ca3c6:
	stw 0xbb8,[r13, 0x1c]
L_8ca3ce:
	stb_s r1,[r13,0x18]
L_8ca3d0:
	st 0x12ad4,[r13, 0x2c]
L_8ca3d8:
	mov r0,0x289
L_8ca3dc:
	stw_s r0,[r13,0x26]
L_8ca3de:
	stb r2,[r13, 0x25]
L_8ca3e2:
	stw 0xbb8,[r13, 0x28]
L_8ca3ea:
	stb r1,[r13, 0x24]
L_8ca3ee:
	st 0x12ad4,[r13, 0x38]
L_8ca3f6:
	mov r0,0x2c2
L_8ca3fa:
	stw_s r0,[r13,0x32]
L_8ca3fc:
	stb r2,[r13, 0x31]
L_8ca400:
	stw 0xbb8,[r13, 0x34]
L_8ca408:
	stb r1,[r13, 0x30]
L_8ca40c:
	st 0x12ad4,[r13, 0x50]
L_8ca414:
	mov r0,0x308
L_8ca418:
	stw r0,[r13, 0x4a]
L_8ca41c:
	mov_s r3,0x2
L_8ca41e:
	stb r3,[r13, 0x49]
L_8ca422:
	mov r2,0x7d0
L_8ca426:
	stw r2,[r13, 0x4c]
L_8ca42a:
	stb r1,[r13, 0x48]
L_8ca42e:
	st 0x12ad4,[r13, 0x5c]
L_8ca436:
	mov r0,0x333
L_8ca43a:
	stw r0,[r13, 0x56]
L_8ca43e:
	stb r3,[r13, 0x55]
L_8ca442:
	stw r2,[r13, 0x58]
L_8ca446:
	stb r1,[r13, 0x54]
L_8ca44a:
	st 0x12ad4,[r13, 0x68]
L_8ca452:
	mov r0,0x34f
L_8ca456:
	stw r0,[r13, 0x62]
L_8ca45a:
	stb r3,[r13, 0x61]
L_8ca45e:
	stw r2,[r13, 0x64]
L_8ca462:
	stb r1,[r13, 0x60]
L_8ca466:
	st 0x12ad4,[r13, 0x80]
L_8ca46e:
	stw r0,[r13, 0x7a]
L_8ca472:
	stb r3,[r13, 0x79]
L_8ca476:
	stw r2,[r13, 0x7c]
L_8ca47a:
	stb r1,[r13, 0x78]
L_8ca47e:
	st 0x12ad4,[r13, 0x8c]
L_8ca486:
	stw r0,[r13, 0x86]
L_8ca48a:
	stb r3,[r13, 0x85]
L_8ca48e:
	stw r2,[r13, 0x88]
L_8ca492:
	stb r1,[r13, 0x84]
L_8ca496:
	st 0x12ad4,[r13, 0x98]
L_8ca49e:
	stw r0,[r13, 0x92]
L_8ca4a2:
	stb r3,[r13, 0x91]
L_8ca4a6:
	stw r2,[r13, 0x94]
L_8ca4aa:
	stb r1,[r13, 0x90]
L_8ca4ae:
	mov_s r0,0x96
L_8ca4b0:
	mov_s r1,0x847abc
L_8ca4b6:
	stw_s r0,[r1,0x1c]
L_8ca4b8:
	mov r0,0x12c
L_8ca4bc:
	stw_s r0,[r1,0x1e]
L_8ca4be:
	mov r0,0x3e8
L_8ca4c2:
	stw_s r0,[r1,0x20]
L_8ca4c4:
	stw_s r2,[r1,0x22]
L_8ca4c6:
	mov_s r0,0x14
L_8ca4c8:
	stb r0,[r13, 0xa4]
L_8ca4cc:
	mov_s r0,0x0
L_8ca4ce:
	b.d L_8c025c
L_8ca4d2:
	stb r0,[r13, 0xa5]
L_8ca4d6:
	nop_s
