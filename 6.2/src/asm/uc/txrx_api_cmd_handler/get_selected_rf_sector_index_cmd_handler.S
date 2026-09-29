/* get_selected_rf_sector_index_cmd_handler @ 0x928224, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_selected_rf_sector_index_cmd_handler(): Invalid sector type specified %d, cid=%d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, mac__read_tsf64_uc, memset0_words_uc, uc_log__emit2, uc_send_evt__get_rf_sector_done, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global get_selected_rf_sector_index_cmd_handler
get_selected_rf_sector_index_cmd_handler:
	.global L_928224
L_928224:
	push_s blink
L_928226:
	push_s r13
L_928228:
	sub_s sp,sp,0x10
L_92822a:
	mov_s r13,r0
L_92822c:
	mov_s r0,sp
L_92822e:
	bl.d L_920a84
L_928232:
	mov_s r1,0x10
L_928234:
	ldb_s r2,[r13,0x1]
L_928236:
	ldb_s r3,[r13]
L_928238:
	brne r2,0x1,L_928252
L_92823c:
	mov_s r1,0x80110c
	.global L_928242
L_928242:
	asl_s r0,r3,0x4
L_928244:
	add2_s r0,r0,r0
L_928246:
	ld_s r0,[r1,r0]
L_928248:
	lsr_s r0,r0,0x8
L_92824a:
	bmsk_s r0,r0,0xe
L_92824c:
	stw r0,[sp]
L_928250:
	b_s L_928272
	.global L_928252
L_928252:
	brne_s r2,0,L_92825c
L_928254:
	mov_s r1,0x801108
L_92825a:
	b_s L_928242
	.global L_92825c
L_92825c:
	mov_s r1,0x1001530
L_928262:
	bl.d L_92d27c
L_928266:
	mov_s r0,0x0
L_928268:
	mov_s r0,blink
L_92826a:
	bl.d L_926618
L_92826e:
	mov r1,0x105
	.global L_928272
L_928272:
	bl.d L_9356cc
L_928276:
	add_s r0,sp,0x8
L_928278:
	mov_s r0,0x0
L_92827a:
	stb r0,[sp, 0x2]
L_92827e:
	bl.d L_927664
L_928282:
	mov_s r0,sp
L_928284:
	b.d L_9202ac
L_928288:
	add_s sp,sp,0x10
L_92828a:
	nop_s
